//
//  AddClip.swift
//  AddClip
//
//  Created by Sam Lally.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct AddClip: View {
    
    // Enable this View to be dismissed to go back when the Save button is tapped
    @Environment(\.presentationMode) var presentationMode
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showClipAddedAlert = false
    @State private var showInputDataMissingAlert = false
    
    // Clip Entity
    @State private var name = ""
    @State private var youtubeID = ""
    
    var body: some View {
        Form {
            Section(header: Text("Clip Name")) {
                TextField("Enter clip name", text: $name)
            }
            
            Section(header: Text("Clip Youtube ID")) {
                TextField("Enter youtube ID", text: $youtubeID)
            }
            .alert(isPresented: $showClipAddedAlert, content: { clipAddedAlert })
        } // End of Form
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.words)
        .disableAutocorrection(true)
        .font(.system(size: 14))
        .alert(isPresented: $showInputDataMissingAlert, content: { inputDataMissingAlert })
        .navigationBarTitle(Text("Add Clip"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                if inputDataValidated() {
                    saveNewClip()
                    showClipAddedAlert = true
                } else {
                    showInputDataMissingAlert = true
                }
            }) {
                Text("Save")
            })
    } // End of body
    
    /*
     ----------------------
     MARK: Clip Added Alert
     ----------------------
     */
    var clipAddedAlert: Alert {
        Alert(title: Text("Clip Added!"),
              message: Text("New clip is added to your clips list!"),
              dismissButton: .default(Text("OK")) {
                  // Dismiss this View and go back
                  presentationMode.wrappedValue.dismiss()
            })
    }
    
    /*
     ------------------------------
     MARK: Input Data Missing Alert
     ------------------------------
     */
    var inputDataMissingAlert: Alert {
        Alert(title: Text("Missing Input Data!"),
              message: Text("All field are required."),
              dismissButton: .default(Text("OK")) )
    }
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {

        if name.isEmpty || youtubeID.isEmpty {
            return false
        }
        
        return true
    }
    
    /*
     -------------------
     MARK: Save New Clip
     -------------------
     */
    func saveNewClip() {
        /*
         =====================================================
         Create an instance of the Clip Entity and dress it up
         =====================================================
        */
        
        // ❎ Create a new Clip entity in CoreData managedObjectContext
        let newClip = Clip(context: managedObjectContext)
        
        // ❎ Dress up the new Album entity
        newClip.name = name
        newClip.youtubeID = youtubeID
        
        /*
         ===========================================
         MARK: ❎ Save Changes to Core Data Database
         ===========================================
         */
        
        do {
            try managedObjectContext.save()
        } catch {
            return
        }
    }
}

struct AddClip_Previews: PreviewProvider {
    static var previews: some View {
        AddClip()
    }
}
