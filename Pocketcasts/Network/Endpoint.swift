//
//  Endpoint.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import Foundation

protocol EndpointKind {
    associatedtype RequestData
    
    static func prepare(_ request: inout URLRequest,
                        with data: RequestData)
}

enum EndpointKinds {
    enum Public: EndpointKind {
        static func prepare(_ request: inout URLRequest,
                            with _: Void) {
        }
    }

    enum Private: EndpointKind {
        static func prepare(_ request: inout URLRequest,
                            with token: String) {
            request.addValue("Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }
    }
}

struct Endpoint<Kind: EndpointKind, Response: Decodable> {
  let path: String
  let method: HTTPMethod
  let parameters: [String: String]
  let rootArrayElement: String?
  
  init(path: String, method: HTTPMethod, parameters: [String: String] = [:], rootArrayElement: String? = nil) {
    self.path = path
    self.method = method
    self.parameters = parameters
    self.rootArrayElement = rootArrayElement
  }
}

extension Endpoint {
  func makeRequest(with data: Kind.RequestData) -> URLRequest? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = Network.baseUrl
    components.path = "/" + path
    components.queryItems = method == .get && !parameters.isEmpty ? parameters.map { URLQueryItem(name: $0, value: $1)} : nil
    
    guard let url = components.url else {
      return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    switch method {
    case .post:
      request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
      let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      request.httpBody = jsonData
    default:
      break
    }
    Kind.prepare(&request, with: data)
    return request
  }
}
