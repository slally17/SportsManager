//
//  Settings.swift
//  Settings
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct Settings: View {
    
    @State private var showEnteredValues = false
    @State private var passwordEntered = ""
    @State private var passwordVerified = ""
    @State private var showUnmatchedPasswordAlert = false
    @State private var showPasswordSetAlert = false
    @State private var showPasswordRemovedAlert = false
    @State private var showPasswordRequirementAlert = false
    
    let securityQuestions = ["In what city or town did your mother and father meet?", "In what city or town were you born?", "What did you want to be when you grew up?", "What do you remember most from your childhood?", "What is the name of the boy or girl that you first kissed?", "What is the name of the first school you attended?", "What is the name of your favorite childhood friend?", "What is the name of your first pet?", "What is your mother's maiden name?", "What was your favorite place to visit as a child?"]
    
    @State private var selectedSecurityQuestionIndex = 4
    @State private var answerToSelectedSecurityQuestion = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Show / Hide Entered Values")) {
                    Toggle(isOn: $showEnteredValues) {
                        Text("Show Entered Values")
                    }
                }
                Section(header: Text("Select a Security Question")) {
                    // Picker: Part 3 of 3
                    Picker("Selected:", selection: $selectedSecurityQuestionIndex) {
                        ForEach(0 ..< securityQuestions.count, id: \.self) {
                            Text(securityQuestions[$0])
                        }
                    }
                }
                Section(header: Text("Enter Answer to Selected Security Question")) {
                    HStack {
                        if showEnteredValues {
                            TextField("Enter Answer", text: $answerToSelectedSecurityQuestion)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .frame(width: 260, height: 36)
                        } else {
                            SecureField("Enter Answer", text: $answerToSelectedSecurityQuestion)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .frame(width: 260, height: 36)
                        }
                        // Button to clear the text field
                        Button(action: {
                            answerToSelectedSecurityQuestion = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                        .padding()
                    }
                }
                Section(header: Text("Enter Password (Must contain one cap and one number)")) {
                    HStack {
                        if showEnteredValues {
                            TextField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .frame(width: 260, height: 36)
                        } else {
                            SecureField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .frame(width: 260, height: 36)
                        }
                        // Button to clear the text field
                        Button(action: {
                            passwordEntered = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                        .padding()
                    }   // End of HStack
                }
                Section(header: Text("Verify Password")) {
                    HStack {
                        if showEnteredValues {
                            TextField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .frame(width: 260, height: 36)
                        } else {
                            SecureField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .frame(width: 260, height: 36)
                        }
                        // Button to clear the text field
                        Button(action: {
                            passwordVerified = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                        .padding()
                        .alert(isPresented: $showPasswordSetAlert, content: { passwordSetAlert })
                    }   // End of HStack
                }
                Section(header: Text("Set Password")) {
                    Button(action: {
                        if !passwordEntered.isEmpty {
                            if passwordEntered == passwordVerified {
                                /*
                                 UserDefaults provides an interface to the user’s defaults database,
                                 where you store key-value pairs persistently across launches of your app.
                                 */
                                
                                let encodedPass = (encrypt(message: passwordEntered, shift: 5))
                                if (checkTextSufficientComplexity(text: passwordEntered)) {
                                    // Store the password in the user’s defaults database
                                    UserDefaults.standard.set(encodedPass, forKey: "Password")
                                    
                                    // Store the selected security question index in the user’s defaults database
                                    UserDefaults.standard.set(securityQuestions[selectedSecurityQuestionIndex], forKey: "SecurityQuestion")
                                    
                                    // Store the answer to the selected security question in the user’s defaults database
                                    UserDefaults.standard.set(answerToSelectedSecurityQuestion, forKey: "SecurityAnswer")
                                    
                                    passwordEntered = ""
                                    passwordVerified = ""
                                    answerToSelectedSecurityQuestion = ""
                                    showPasswordSetAlert = true
                                }
                                else {
                                    showPasswordRequirementAlert = true
                                }
                                
                                
                            } else {
                                showUnmatchedPasswordAlert = true
                            }
                        }
                    }) {
                        Text("Set Password")
                            .frame(width: 300, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                    }
                    .alert(isPresented: $showUnmatchedPasswordAlert, content: { unmatchedPasswordAlert })
                    .alert(isPresented: $showPasswordRequirementAlert, content: { passwordRequirmentAlert })
                }
                Section(header: Text("Remove Password")) {
                    Button(action: {
                        // Set password to nil in the user’s defaults database
                        UserDefaults.standard.set(nil, forKey: "Password")
                        
                        // Set security question to nil in the user’s defaults database
                        UserDefaults.standard.set(nil, forKey: "SecurityQuestion")
                        
                        showPasswordRemovedAlert = true
                    }) {
                        Text("Remove Password")
                            .frame(width: 300, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                    }
                    .alert(isPresented: $showPasswordRemovedAlert, content: { passwordRemovedAlert })
                }
                
            }   // End of Form
            // Set font and size for the whole Form content
            .font(.system(size: 14))
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
            
        }   // End of NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        
    }   // End of var
    
    //-------------------
    // Password Requirement Alert
    //-------------------
    var passwordRequirmentAlert: Alert {
        Alert(title: Text("Password Does Not Meet Requirements!"),
              message: Text("Password requires at least one captial letter and a number"),
              dismissButton: .default(Text("OK")) )
    }
    
    //-------------------
    // Password Set Alert
    //-------------------
    var passwordSetAlert: Alert {
        Alert(title: Text("Password Set!"),
              message: Text("Password you entered is set to unlock the app!"),
              dismissButton: .default(Text("OK")) )
    }
    
    //-------------------------
    // Unmatched Password Alert
    //-------------------------
    var unmatchedPasswordAlert: Alert {
        Alert(title: Text("Unmatched Password!"),
              message: Text("Two entries of the password must match!"),
              dismissButton: .default(Text("OK")) )
    }
    
    //-----------------------
    // Password Removed Alert
    //-----------------------
    var passwordRemovedAlert: Alert {
        Alert(title: Text("Password Removed!"),
              message: Text("You can now unclock the app without a password!"),
              dismissButton: .default(Text("OK")) )
    }
    
    //returns true if this password contains both a number and a capitalized letter
    func checkTextSufficientComplexity(text : String) -> Bool{


        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        


        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
      
        return capitalresult && numberresult

    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

