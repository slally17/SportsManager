//
//  ClipsList.swift
//  ClipsList
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct ClipsList: View {
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all Clip entities in the database
    @FetchRequest(fetchRequest: Clip.allClipsFetchRequest()) var allClips: FetchedResults<Clip>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allClips) { aClip in
                    NavigationLink(destination: WebView(url: "http://www.youtube.com/embed/\(aClip.youtubeID ?? "")") // Given in WebView.swift
                                    .navigationBarTitle(Text(aClip.name ?? ""), displayMode: .inline)) {
                        ClipItem(clip: aClip)
                    }
                }
                .onDelete(perform: delete)
                
            }   // End of List
                .navigationBarTitle(Text("Clips List"), displayMode: .inline)
                
                // Place the Edit button on left and Add (+) button on right of the navigation bar
                .navigationBarItems(leading: EditButton(), trailing:
                    NavigationLink(destination: AddClip()) {
                        Image(systemName: "plus")
                })
            
        }   // End of NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    } // End of body
    
    /*
     --------------------------
     MARK: Delete Selected Clip
     --------------------------
     */
    func delete(at offsets: IndexSet) {
        /*
        'offsets.first' is an unsafe pointer to the index number of the array element
        to be deleted. It is nil if the array is empty. Process it as an optional.
        */
        if let index = offsets.first {
            let clipEntityToDelete = allClips[index]
            // ❎ CoreData Delete operation
            managedObjectContext.delete(clipEntityToDelete)
            // ❎ CoreData Save operation
            do {
                try managedObjectContext.save()
            } catch {
                print("Unable to delete!")
            }
        }
    }
}

struct ClipsList_Previews: PreviewProvider {
    static var previews: some View {
        ClipsList()
    }
}
