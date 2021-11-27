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

var playersFound = [Weather]()
fileprivate var weatherFound = Weather(id: UUID(), city: "", country: "", latitude: 0, longitude: 0, dateAndTime: "", icon: "", description: "", humidity: 0, minTemp: 0, maxTemp: 0)

fileprivate var previousCity = "", previousCountry = ""

/*
==================================
MARK: Obtain Weather Data from API
==================================
*/
public func obtainWeatherDataFromApi(city: String, country: String) {
    // Avoid executing this function if already done for the same city and country
    if city == previousCity && country == previousCountry {
        return
    } else {
        previousCity = city
        previousCountry = country
    }
    
    // Initialization
    weatherFound = Weather(id: UUID(), city: "", country: "", latitude: 0, longitude: 0, dateAndTime: "", icon: "", description: "", humidity: 0, minTemp: 0, maxTemp: 0)
    weathersFound = [Weather]()
    
    
    /*
     *********************************************
     *   Obtaining API Search Query URL Struct   *
     *********************************************
     */
    let cityFormatted = city.replacingOccurrences(of: " ", with: "%20")
    let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityFormatted),\(country)&units=imperial&appid=\(apiKey)"
    
    print(apiUrl)
    
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
        "host": "api.openweathermap.org"
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
            var weatherDataDictionary = Dictionary<String, Any>()
            
            if let jsonObject = jsonResponse as? [String: Any] {
                weatherDataDictionary = jsonObject
                var latitude = 0.0, longitude = 0.0
                
                //---------------------------------
                // Obtain Weather Lat/Long
                //---------------------------------
                if let cityDictionary = weatherDataDictionary["city"] as? [String: Any] {
                    if let coordDictionary = cityDictionary["coord"] as? [String: Any] {
                        if let weatherLatitude = coordDictionary["lat"] as? Double {
                            latitude = weatherLatitude
                        }
                        if let weatherLongitude = coordDictionary["lon"] as? Double {
                            longitude = weatherLongitude
                        }
                    }
                } else {
                    semaphore.signal()
                    return
                }
                
                if let jsonArray = weatherDataDictionary["list"] as? [Any] {
                    for jArray in jsonArray {
                        if let jObject = jArray as? [String:Any] {
                            weatherDataDictionary = jObject
                            var dateAndTime = "", icon = "", description = "", humidity = 0, minTemp = 0.0, maxTemp = 0.0
                            
                            //-----------------------------------------
                            // Obtain Weather Temp Min/Max and Humidity
                            //-----------------------------------------
                            if let mainDictionary = weatherDataDictionary["main"] as? [String: Any] {
                                if let weatherMin = mainDictionary["temp_min"] as? Double {
                                    minTemp = weatherMin
                                }
                                if let weatherMax = mainDictionary["temp_max"] as? Double {
                                    maxTemp = weatherMax
                                }
                                if let weatherHumidity = mainDictionary["humidity"] as? Int {
                                    humidity = weatherHumidity
                                }
                            }
                            
                            //------------------------------------
                            // Obtain Weather Description and Icon
                            //------------------------------------
                            if let weatherArray = weatherDataDictionary["weather"] as? [Any] {
                                if let weatherDictionary = weatherArray[0] as? [String: Any] {
                                    if let weatherDescription = weatherDictionary["description"] as? String {
                                        description = weatherDescription
                                    }
                                    if let weatherIcon = weatherDictionary["icon"] as? String {
                                        icon = weatherIcon
                                    }
                                }
                            }
                            
                            //-----------------------------
                            // Obtain Weather Date and Time
                            //-----------------------------
                            if let weatherDateAndTime = weatherDataDictionary["dt_txt"] as? String {
                                dateAndTime = weatherDateAndTime
                            }
                            
                            weatherFound = Weather(id: UUID(), city: city, country: country, latitude: latitude, longitude: longitude, dateAndTime: dateAndTime, icon: icon, description: description, humidity: humidity, minTemp: minTemp, maxTemp: maxTemp)
                            
                            weathersFound.append(weatherFound)
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
