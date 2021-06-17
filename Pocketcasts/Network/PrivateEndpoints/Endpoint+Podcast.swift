//
//  Endpoint+Podcast.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 17/06/2021.
//

extension Endpoint where Kind == EndpointKinds.Private, Response == [Podcast] {
  static let listPodcasts: Self = Endpoint(path: "user/podcast/list", method: .post, parameters: ["v": "1"], rootArrayElement: "podcasts")
}
