//
//  PodcastCell.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 20/06/2021.
//

import SwiftUI

struct PodcastCell: View {
  let podcast: Podcast
  var body: some View {
      AsyncImage(url: podcast.imageUrl) { image in
        image.resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(8)
      } placeholder: {
        Color.secondaryBackground
          .redacted(reason: .placeholder)
          .aspectRatio(contentMode: .fit)
          .cornerRadius(8)
      }
  }
}

struct PodcastCell_Previews: PreviewProvider {
    static var previews: some View {
      PodcastCell(podcast: Podcast(id: UUID(uuidString: "026f6750-b3ed-0133-2e57-6dc413d6d41d")!, title: "La Méthode scientifique", author: "France Culture", description: "Rendez-vous sur l'application Radio France pour découvrir tous les autres épisodes / Une heure de savoir autour des sciences, toutes les sciences, et sur les problématiques éthiques, politiques, économiques et sociales qui font l'actualité de la recherche. Du lundi au vendredi de 16h à 17h.", rawUrl: "http://www.radiofrance.fr/", lastEpisodePublishedDate: Date(), unplayed: true, lastEpisodeId: UUID(uuidString: "470d1c8b-a56c-47b7-89d2-5f2ca20b73ad")!, lastEpisodePlayingStatus: 1, lastEpisodeArchived: false, autoSkipLast: 0, episodeSortOrder: 3, autoStartFrom: 0))
    }
}
