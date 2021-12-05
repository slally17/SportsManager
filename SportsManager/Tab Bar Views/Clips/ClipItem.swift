//
//  ClipItem.swift
//  ClipItem
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct ClipItem: View {
    
    let clip: Clip
    
    // ❎ CoreData FetchRequest returning all Clip entities in the database
    @FetchRequest(fetchRequest: Clip.allClipsFetchRequest()) var allClips: FetchedResults<Clip>
    
    var body: some View {
        HStack {
            getImageFromUrl(url: "https://img.youtube.com/vi/\(clip.youtubeID ?? "")/mqdefault.jpg", defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            Text(clip.name ?? "")
        }
        .font(.system(size: 14))
    } // End of body
}
