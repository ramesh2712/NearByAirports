//
//  NearByAirportsDetail.swift
//  NearestAirports
//
//  Created by ramesh on 14/12/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import Foundation

class NearByAirportsDetail {
    
    //The variable value can only be set from view model.
    private (set) var airportList: [Airport]! = nil
    
    private (set) var searchedAirportList: [Airport]! = nil

    // Near By Airports
    private (set) var nearByAirports = [[String:Any]]()
    
    //Data Model of the ViewModel
    private var dataModel = [Airport]()
    
    // Consider this as a data providing API request or JSON data in general app environment.
    private func airtPortsData() -> [[String:Any]] {
        return DataGenerator.readJSONData()
    }
    
    // Communication type - 1 using functions
    func viewDidLoad() {
        configureDataModel(airports: airtPortsData())
        configureOutput()
    }
    
    //Configure the data model required for the UI population.
    private func configureDataModel(airports : [[String: Any]]) {
        for airport in airports {
            print(airport)
            let airportModel : Airport = Airport(data: airport)
            dataModel.append(airportModel)
        }
    }
    
    //Configure the output properties that are to be accessed by the view.
    private func configureOutput() {
        airportList = dataModel
        searchedAirportList = dataModel
    }
    
    ///////////////////////////////////////////////////////////////////////
    ///  This function converts decimal degrees to radians              ///
    ///////////////////////////////////////////////////////////////////////
    func deg2rad(deg:Double) -> Double {
        return deg * Double.pi / 180
    }

    ///////////////////////////////////////////////////////////////////////
    ///  This function converts radians to decimal degrees              ///
    ///////////////////////////////////////////////////////////////////////
    func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / Double.pi
    }
    
    func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double , airportCode : String) -> (distance: Double , code: String) {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist = dist * 60 * 1.1515
        return (dist,airportCode)
    }
    
    func searchedCity(searchText : String) {
        
        if airportList.count > 0
        {
            let searchedArr =  self.airportList.filter { $0.city.contains(searchText) }
            self.searchedAirportList = searchedArr
        }
    }
    
    func resetAirportList(){
        searchedAirportList = airportList
    }
    
    
    func findTopFiveNearByAirports(selectedIndexPath : IndexPath) {
        
        let airport = self.airportList[selectedIndexPath.row]
        var distanceArray = [[String:Any]]()
          
        // find out distance from selected location.
          if airport.lat != 0.0 || airport.lon != 0.0 {
              for airportObject in self.airportList {
                if (airportObject.code != airport.code && airport.type == "Airports") {
                    let distance = self.distance(lat1: airport.lat, lon1: airport.lon, lat2: airportObject.lat, lon2: airportObject.lon , airportCode: airportObject.code).distance
                    let code = self.distance(lat1: airport.lat, lon1: airport.lon, lat2: airportObject.lat, lon2: airportObject.lon , airportCode: airportObject.code).code
                    let dict = ["distance":distance ,
                                  "code": code,
                                  "runway_length" : airportObject.runway_length,
                                  "name": airportObject.name,
                                  "country": airportObject.country] as [String : Any]
                      distanceArray.append(dict)
                  }
              }
          }
        // Sort Ascending order based on distance
          let sortedResults = (distanceArray as NSArray).sortedArray(using: [NSSortDescriptor(key: "distance", ascending: true)]) as! [[String:AnyObject]]
        // Fetch Top 5 nearest Airport location
          let searchResults = sortedResults.prefix(5)
          nearByAirports = Array(searchResults)
    }
}
