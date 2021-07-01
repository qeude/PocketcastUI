//
//  Endpoint+Episode.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 23/06/2021.
//

import Foundation
extension Endpoint where Kind == EndpointKinds.Private, Response == [Podcast] {
  static let upNext: Self = Endpoint(path: "up_next/list", method: .post, parameters: ["version": "2"], rootArrayElement: "episodes")
}
