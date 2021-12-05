//
//  AppDelegate.swift
//  AppDelegate
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /*
        ***************************
        *   Create Teams Database *
        ***************************
        */
        createTeamsDatabase()      // Given in TeamsData.swift
        
        /*
        *****************************
        *   Create Players Database *
        *****************************
        */
        createPlayersDatabase()      // Given in PlayersData.swift
        
        return true
    }
}

