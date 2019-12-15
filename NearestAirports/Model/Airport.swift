//
//  Airport.swift
//  NearestAirports
//
//  Created by ramesh on 14/12/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//
/*
 {
   "code": "AAA",
   "lat": "-17.3595",
   "lon": "-145.494",
   "name": "Anaa Airport",
   "city": "Anaa",
   "state": "Tuamotu-Gambier",
   "country": "French Polynesia",
   "woeid": "12512819",
   "tz": "Pacific\/Midway",
   "phone": "",
   "type": "Airports",
   "email": "",
   "url": "",
   "runway_length": "4921",
   "elev": "7",
   "icao": "NTGA",
   "direct_flights": "2",
   "carriers": "1"
 }
 */

import Foundation

struct Airport {
    var code = ""
    var lat = 0.0
    var lon = 0.0
    var name = ""
    var city = ""
    var state = ""
    var country = ""
    var woeid = ""
    var tz = ""
    var phone = ""
    var type = ""
    var email = ""
    var url = ""
    var runway_length = 0
    var elev = 0
    var icao = ""
    var direct_flights = 0
    var carriers = 0
    
    init(data: [String: Any]) {
        
        code = data["code"] as! String
        if let latInString = data["lat"]  as? String {
            lat = Double.init(latInString)!
        }
        if let longitudeInString = data["lon"] as? String {
            lon = Double.init(longitudeInString)!
        }
        
        name = data["name"] as! String
        city = data["city"] as! String
        
        if let stateInString = data["state"]  as? String {
            state = stateInString
        } else {
            state = ""
        }
        
       // state = data["state"] as! String
        country = data["country"] as! String
        woeid = data["woeid"] as! String
        phone = data["phone"] as! String
        type = data["type"] as! String
        email = data["email"] as! String
        url = data["url"] as! String
        if let runway_lengthInString = data["runway_length"]  as? String {
            runway_length = Int.init(runway_lengthInString)!
        } else {
            runway_length = 0
        }
       // runway_length =  Int.init(runway_lengthInString)!
        
        if let elevInString = data["elev"]  as? String {
            elev = Int.init(elevInString)!
        } else {
            elev = 0
        }
        icao = data["icao"] as! String
        direct_flights = Int.init((data["direct_flights"] as! String))!
        carriers = Int.init((data["carriers"] as! String))!
    }
}

extension String {
    func toDouble() -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US_POSIX")
        return numberFormatter.number(from: self)?.doubleValue
    }

    func toInt() -> Int? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US_POSIX")
        return numberFormatter.number(from: self)?.intValue
    }
}
