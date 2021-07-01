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

//struct PodcastCell_Previews: PreviewProvider {
//  static var previews: some View {
//    PodcastCell(podcast: ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//  }
//}
