//
//  NowListening.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 22/06/2021.
//

import SwiftUI

struct NowListening: View {
  @Binding var episode: Episode?
  @State private var value: Double = 0
  
  var body: some View {
    HStack(spacing: 0) {
      AsyncImage(url: episode?.podcast.imageUrl) { image in
        image.resizable()
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        Color.primaryGray
          .redacted(reason: .placeholder)
          .aspectRatio(contentMode: .fit)
      }
      ZStack {
        Color.secondaryGray
        VStack{
          if(episode != nil) {
            Text(episode?.title ?? "")
            Text("\(episode?.podcast.title ?? "") - \(episode?.formattedDate ?? "")")
            Slider(value: $value, in: 0...100)
          } else {
            Logo()
              .background(color: .tertiaryGray)
              .foreground(color: .primaryGray)
          }
        }
        .padding(3)
        .frame(minWidth: 0, maxWidth: .infinity)
      }
    }
  }
}

struct NowListening_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        NowListening(episode: .constant(nil))
          .frame(width: 300, height: 80)
        NowListening(episode: .constant(Episode(id: UUID(uuidString: "487b142f-728a-4c54-b0cd-9ef466fcdd12")!, title: "99: “Structured concurrency”, with special guest Doug Gregor", rawUrl: "https://traffic.libsyn.com/swiftbysundell/SwiftBySundell99.mp3", podcast: Podcast(id: UUID(uuidString: "dc696b00-628d-0135-902c-63f4b61a9224")!, title: "Swift by Sundell", author: "John Sundell", description: "In-depth conversations about Swift and software development in general, hosted by John Sundell.", rawUrl: "https://www.swiftbysundell.com/podcast", lastEpisodePublishedDate: Date(), unplayed: false, lastEpisodeId: UUID(uuidString: "487b142f-728a-4c54-b0cd-9ef466fcdd12")!, lastEpisodePlayingStatus: 2, lastEpisodeArchived: false, autoSkipLast: 0, episodeSortOrder: 3, autoStartFrom: 0), publicationDate: Date())))
          .frame(width: 300, height: 80)
      }
    }
}
