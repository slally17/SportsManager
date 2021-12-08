//
//  SearchDatabase.swift
//  SearchDatabase
//
//  Created by Sam Lally.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct SearchDatabase: View {
    
    let categoryOptions = ["Team", "Player"]
    @State private var selectedCategoryIndex = 0
    
    @State private var searchFieldValue = ""
    @State private var showMissingInputDataAlert = false
    @State private var searchCompleted = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Category")) {
                    Picker("Search Category", selection: $selectedCategoryIndex) {
                        ForEach(0 ..< categoryOptions.count) { index in
                            Text(categoryOptions[index]).tag(index)
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                }
                
                Section(header: Text("Enter name to search for")) {
                    HStack {
                        TextField("Enter team/player name", text: $searchFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.default)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                        
                        // Button to clear the text field
                        Button(action: {
                            searchFieldValue = ""
                            showMissingInputDataAlert = false
                            searchCompleted = false
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                        .frame(minWidth: 300, maxWidth: 500)
                        .alert(isPresented: $showMissingInputDataAlert, content: { missingInputDataAlert })
                }
                    
                Section(header: Text("Search Player/Team by Name")) {
                    HStack {
                        Button(action: {
                            if inputDataValidated() {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    /*
                                     Execute the following code after 0.1 second of delay
                                     so that they are not executed during the view update.
                                     */
                                    searchApi()
                                    searchCompleted = true
                                }
                            } else {
                                showMissingInputDataAlert = true
                            }
                        }) {
                            Text(searchCompleted ? "Search Completed" : "Search")
                        }
                        .frame(width: 240, height: 36, alignment: .center)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color.black, lineWidth: 1)
                        )
                    }   // End of HStack
                }
                    
                if searchCompleted {
                    Section(header: Text("Show Details of the Players/Teams Found")) {
                        NavigationLink(destination: showSearchResults) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                Text("Show Player/Team Details")
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(minWidth: 300, maxWidth: 500)
                    }
                }
            } // End of Form
            .navigationBarTitle(Text("Search Database"), displayMode: .inline)
            .onAppear() {
                searchCompleted = false
            }
        } // End of NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    } // End of body
    
    /*
    ------------------
    MARK: Search API
    ------------------
    */
    func searchApi() {
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let nameTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // public function getApiDataByNationalParkName is given in SearchByNameApiData.swift
        if(selectedCategoryIndex == 0) {
            obtainTeamDataFromApi(query: nameTrimmed)
        }
        else {
            obtainPlayerDataFromApi(query: nameTrimmed, category: "player")
        }
    }
    
    /*
    ---------------------------
    MARK: Show Search Results
    ---------------------------
    */
    var showSearchResults: some View {
        if(selectedCategoryIndex == 0) {
            if(teamsFound.isEmpty) {
                return AnyView(notFoundMessage)
            }
            else {
                return AnyView(SearchTeamsList())
            }
        }
        else {
            if(playersFound.isEmpty) {
                return AnyView(notFoundMessage)
            }
            else {
                return AnyView(SearchPlayersList())
            }
        }
    }
    
    /*
    -----------------------------------
    MARK: Team/Player Not Found Message
    -----------------------------------
    */
    var notFoundMessage: some View {
        
        ZStack {    // Color Background to Ivory color
            Color(red: 1.0, green: 1.0, blue: 240/255).edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .imageScale(.large)
                    .font(Font.title.weight(.medium))
                    .foregroundColor(.red)
                    .padding()
                Text("No Team/Player Found!\n\nThe API did not return a park under the entered name \(searchFieldValue). Please make sure that you enter a valid name as required by the API.")
                    .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                    .multilineTextAlignment(.center)
                    .padding()
            } // End of VStack
        
        } // End of ZStack
    }
    
    /*
     --------------------------------
     MARK: Missing Input Data Alert
     --------------------------------
     */
    var missingInputDataAlert: Alert {
        Alert(title: Text("The Search Field is Empty!"),
              message: Text("Please enter a name to search for!"),
              dismissButton: .default(Text("OK")))
        /*
         Tapping OK resets @State var showMissingInputDataAlert to false.
         */
    }
    
    /*
     -----------------------------
     MARK: Input Data Validation
     -----------------------------
     */
    func inputDataValidated() -> Bool {
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if queryTrimmed.isEmpty {
            return false
        }
        return true
    }
}

struct SearchDatabase_Previews: PreviewProvider {
    static var previews: some View {
        SearchDatabase()
    }
}
