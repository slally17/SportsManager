//
//  PlayerAPIData.swift
//  PlayerAPIData
//
//  Created by Sam Lally on 11/26/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation
import SwiftUI

private let apiKey = "40130162"

var playersFound = [PlayerStruct]()
fileprivate var playerFound = PlayerStruct(name: "", sport: "", position: "", height: "", weight: "", about: "")

fileprivate var previousQuery = "", previousCategory = ""

/*
==================================
MARK: Obtain Weather Data from API
==================================
*/
public func obtainPlayerDataFromApi(query: String, category: String) {
    // Avoid executing this function if already done for the same query
    if query == previousQuery && category == previousCategory {
        return
    } else {
        previousQuery = query
        previousCategory = category
    }
    
    // Initialization
    playerFound = PlayerStruct(name: "", sport: "", position: "", height: "", weight: "", about: "")
    playersFound = [PlayerStruct]()
    
    
    /*
     *********************************************
     *   Obtaining API Search Query URL Struct   *
     *********************************************
     */
    let queryFormatted = query.replacingOccurrences(of: " ", with: "%20")
    var apiUrl = ""
    if category == "player" {
        apiUrl = "https://www.thesportsdb.com/api/v1/json/\(apiKey)/searchplayers.php?p=\(queryFormatted)"
    }
    else if category == "team" {
        apiUrl = "https://www.thesportsdb.com/api/v1/json/\(apiKey)/lookup_all_players.php?id=\(queryFormatted)"
    }
    
    /*
     searchQuery may include unrecognizable foreign characters inputted by the user,
     e.g., Côte d'Ivoire, that can prevent the creation of a URL struct from the
     given apiUrl string. Therefore, we must test it as an Optional.
    */
    var apiQueryUrlStruct: URL?
    
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        return
    }
    
    /*
    *******************************
    *   HTTP GET Request Set Up   *
    *******************************
    */
    
    let headers = [
        "accept": "application/json",
        "cache-control": "no-cache",
        "connection": "keep-alive",
        "host": "thesportsdb.com"
    ]

    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)

    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    /*
    *********************************************************************
    *  Setting Up a URL Session to Fetch the JSON File from the API     *
    *  in an Asynchronous Manner and Processing the Received JSON File  *
    *********************************************************************
    */
    
    /*
     Create a semaphore to control getting and processing API data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the JSON file from the API is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */

        // Process input parameter 'error'
        guard error == nil else {
            // breweryFound will have the initial values set as above
            semaphore.signal()
            return
        }
        
        /*
         ---------------------------------------------------------
         🔴 Any 'return' used within the completionHandler Closure
            exits the Closure; not the public function it is in.
         ---------------------------------------------------------
         */

        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            // breweryFound will have the initial values set as above
            semaphore.signal()
            return
        }

        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            // breweryFound will have the initial values set as above
            semaphore.signal()
            return
        }
        
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
             Foundation framework’s JSONSerialization class is used to convert JSON data
             into Swift data types such as Dictionary, Array, String, Number, or Bool.
             */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                               options: JSONSerialization.ReadingOptions.mutableContainers)
            /*
             JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
             Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
             where Dictionary Key type is String and Value type is Any (instance of any type)
             */
            var playerDictionary = Dictionary<String, Any>()
            
            if let jsonDictionary = jsonResponse as? [String: Any] {
                if let jsonArray = jsonDictionary["player"] as? [Any] {
                    for jArray in jsonArray {
                        if let jObject = jArray as? [String:Any] {
                            playerDictionary = jObject
                            var name = "", sport = "", position = "", height = "", weight = "", about = ""
                            
                            //-------------------
                            // Obtain Player Name
                            //-------------------
                            if let playerName = playerDictionary["strPlayer"] as? String {
                                name = playerName
                            }
                            else {
                                semaphore.signal()
                                return
                            }
                            
                            //--------------------
                            // Obtain Player Sport
                            //--------------------
                            if let playerSport = playerDictionary["strSport"] as? String {
                                sport = playerSport
                            }
                            
                            //-----------------------
                            // Obtain Player Position
                            //-----------------------
                            if let playerPosition = playerDictionary["strPosition"] as? String {
                                position = playerPosition
                            }
                            
                            //---------------------
                            // Obtain Player Height
                            //---------------------
                            if let playerHeight = playerDictionary["strHeight"] as? String {
                                height = playerHeight
                            }
                            
                            //---------------------
                            // Obtain Player Weight
                            //---------------------
                            if let playerWeight = playerDictionary["strWeight"] as? String {
                                weight = playerWeight
                            }
                            
                            //--------------------
                            // Obtain Player About
                            //--------------------
                            if let playerAbout = playerDictionary["strDescriptionEN"] as? String {
                                about = playerAbout
                            }
                        
                            
                            playerFound = PlayerStruct(name: name, sport: sport, position: position, height: height, weight: weight, about: about)
                            
                            playersFound.append(playerFound)
                        } else {
                            semaphore.signal()
                            return
                        }
                    }
                } else {
                    semaphore.signal()
                    return
                }
            } else {
                semaphore.signal()
                return
            }
        } catch {
            semaphore.signal()
            return
        }
        semaphore.signal()
    }).resume()
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.

     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 10 seconds expires.
    */
    _ = semaphore.wait(timeout: .now() + 10)
}
