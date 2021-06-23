//
//  Request.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 16/06/2021.
//

import Foundation

extension URLSession {
  enum APIError: Error {
    case invalidEndpoint
    case invalidResponse
    case decodingError
    case unauthorized
    case forbidden
    case serverError
  }
  
  func send<K, R>(endpoint: Endpoint<K, R>, using requestData: K.RequestData, decoder: JSONDecoder = .init(context: PersistenceController.shared.container.viewContext)) async throws -> R {
    decoder.dateDecodingStrategy = .iso8601
    guard let request = endpoint.makeRequest(with: requestData) else {
      throw APIError.invalidEndpoint
    }
    var (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
    guard let response = response as? HTTPURLResponse else {
      throw APIError.invalidResponse
    }
    switch response.statusCode {
    case 200...299:
      break
    case 401:
      throw APIError.unauthorized
    case 403:
      throw APIError.forbidden
    case 500:
      throw APIError.serverError
    default:
      break
    }
    if let rootArrayElement = endpoint.rootArrayElement,
       let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
       let resultJson = json[rootArrayElement] {
      data = try JSONSerialization.data(withJSONObject: resultJson, options: [])
    }
    do {
      let result = try decoder.decode(R.self, from: data)
      return result
    } catch {
      print(error)
      throw APIError.decodingError
    }
  }
}
