//
//  LoginView.swift
//  LoginView
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct LoginView : View {
    
    // Binding input parameter
    @Binding var canLogin: Bool
    
    // State variables
    @State private var enteredPassword = ""
    @State private var showInvalidPasswordAlert = false
    @State private var showNoBiometricCapabilityAlert = false
    
    var body: some View {
        NavigationView {
            // Background View
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                
            // Foreground View
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image("Welcome")
                        .padding(.bottom, 10)
                    
                    Text("Sports Manager")
                        .font(.headline)
                        .padding()
                    
                    Text("Powered By")
                        .font(.system(size: 18, weight: .light, design: .serif))
                        .italic()
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                    
                    Link(destination: URL(string: "https://www.thesportsdb.com/api.php")!) {
                        HStack {
                            Image("sportsdb")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                        }
                    }
                    
                    SecureField("Password", text: $enteredPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300, height: 36)
                        .padding()
                    
                    HStack {
                        Button(action: {
                            /*
                             UserDefaults provides an interface to the user’s defaults database,
                             where you store key-value pairs persistently across launches of your app.
                             */
                            // Retrieve the password from the user’s defaults database under the key "Password"
                            let validPassword = UserDefaults.standard.string(forKey: "Password")
                            let decodedPass = encrypt(message: validPassword ?? "Pass", shift: -5)
                            
                            /*
                             If the user has not yet set a password, validPassword = nil
                             In this case, allow the user to login.
                             */
                            if validPassword == nil || enteredPassword == decodedPass {
                                canLogin = true
                            } else {
                                showInvalidPasswordAlert = true
                            }
                        }) {
                            Text("Login")
                                .frame(width: 100, height: 36, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(Color.black, lineWidth: 1)
                                )
                        }
                        .padding()
                        
                        if UserDefaults.standard.string(forKey: "SecurityQuestion") != nil {
                            NavigationLink(destination: ResetPassword()) {
                                Text("Forgot Password")
                                    .frame(width: 180, height: 36, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .strokeBorder(Color.black, lineWidth: 1)
                                    )
                            }
                            .padding()
                        }
                    }   // End of HStack
                    
                    /*
                     *********************************************************
                     *   Biometric Authentication with Face ID or Touch ID   *
                     *********************************************************
                     */
                    
                    // Enable biometric authentication only if a password has already been set
                    if UserDefaults.standard.string(forKey: "Password") != nil {
                        Button(action: {
                            // authenticateUser() is given in UserAuthentication
                            authenticateUser() { status in
                                switch (status) {
                                case .Success:
                                    canLogin = true
                                    print("case .Success")
                                case .Failure:
                                    canLogin = false
                                    print("case .Failure")
                                case .Unavailable:
                                    canLogin = false
                                    showNoBiometricCapabilityAlert = true
                                    print("case .Unavailable")
                                }
                            }
                        }) {
                            Text("Use Face ID or Touch ID")
                                .frame(width: 240, height: 36, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(Color.black, lineWidth: 1)
                                )
                        }
                        HStack {
                            Image(systemName: "faceid")
                                .font(.system(size: 40))
                                .padding()
                            Image(systemName: "touchid")
                                .font(.system(size: 40))
                                .padding()
                        }
                    }
                }   // End of VStack
            }   // End of ScrollView
            }   // End of ZStack
            .alert(isPresented: $showInvalidPasswordAlert, content: { invalidPasswordAlert })
            .navigationBarHidden(true)
            
        }   // End of NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $showNoBiometricCapabilityAlert, content: { noBiometricCapabilityAlert })
        
    }   // End of var
    
    //-----------------------
    // Invalid Password Alert
    //-----------------------
    var invalidPasswordAlert: Alert {
        Alert(title: Text("Invalid Password!"),
              message: Text("Please enter a valid password to unlock the app!"),
              dismissButton: .default(Text("OK")) )
        // Tapping OK resets showInvalidPasswordAlert to false
    }
    
     //------------------------------
     // No Biometric Capability Alert
     //------------------------------
    var noBiometricCapabilityAlert: Alert{
        Alert(title: Text("Unable to Use Biometric Authentication!"),
              message: Text("Your device does not support biometric authentication!"),
              dismissButton: .default(Text("OK")) )
        // Tapping OK resets showNoBiometricCapabilityAlert to false
    }
    
}

