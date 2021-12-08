//
//  SearchTeamsDetails.swift
//  SearchTeamsDetails
//
//  Created by Sam Lally.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct SearchTeamsDetails: View {
    
    // Enable this View to be dismissed to go back when the Save button is tapped
    @Environment(\.presentationMode) var presentationMode
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showChangesSavedAlert = false
    
    let team: TeamStruct
    
    var body: some View {
        Form {
            Section(header: Text("Team Name")) {
                Text(team.name)
            }
            
            Section(header: Text("Team Logo")) {
                getImageFromUrl(url: team.photoUrl, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            
            Section(header: Text("Team League")) {
                Text(team.league)
            }
            
            Section(header: Text("Team About")) {
                Text(team.about)
            }
        } // End of Form
        .navigationBarTitle(Text("\(team.name) Details"), displayMode: .inline)
        .alert(isPresented: $showChangesSavedAlert, content: { changesSavedAlert })
        .font(.system(size: 14))
        .navigationBarItems(trailing:
            Button(action: {
                addNewTeam()
                showChangesSavedAlert = true
            }) {
                Text("Add")
            })
    } // End of body
    
    /*
     -------------------
     MARK: Alert Message
     -------------------
     */
    var changesSavedAlert: Alert {
        return Alert(title: Text("Team Added!"),
          message: Text("Your team have been successfully saved to the database."),
          dismissButton: .default(Text("OK")) {
              presentationMode.wrappedValue.dismiss()
            })
    }
    
    /*
     ------------------
     MARK: Add New Team
     ------------------
     */
    func addNewTeam() {
        // ❎ Create a new Team entity in CoreData managedObjectContext
        let newTeam = Team(context: managedObjectContext)
        
        // ❎ Dress up the new Team entity
        newTeam.name = team.name
        newTeam.sport = team.sport
        newTeam.league = team.league
        newTeam.about = team.about
        
        // ❎ Create an instance of the Photo Entity in CoreData managedObjectContext
        let photoEntity = Photo(context: managedObjectContext)
        // Obtain the  photo image from Assets.xcassets as UIImage
        let photoUIImage = getUIImageFromUrl(url: team.photoUrl, defaultFilename: "ImageUnavailable")
        // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
        let photoData = photoUIImage.jpegData(compressionQuality: 1.0)
        // Assign photoData to Core Data entity attribute of type Data (Binary Data)
        photoEntity.photoData = photoData!
        
        // ❎ Establish One-to-One relationship between Team and Photo
        newTeam.photo = photoEntity      // A team can have only one photo
        photoEntity.team = newTeam      // A photo can belong to only one team
        
        // ❎ CoreData Save operation
        do {
            try managedObjectContext.save()
        } catch {
            return
        }
    }
}
