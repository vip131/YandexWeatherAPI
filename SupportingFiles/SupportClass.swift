//
//  SupportClass.swift
//  YandexWeatherAPI
//
//  Created by Admin on 12.01.2021.
//  Copyright © 2021 DmitryChaschin. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class SupportClass {
    
    class func check(string: String)-> Bool {
        let validCharacters = NSCharacterSet.letters.inverted
        let components = string.components(separatedBy: validCharacters)
        if components.count > 1 {
            return false
        }
        return true
    }
    
    class func getCoorditateFrom(string: String, handler: @escaping(_ coordinate:CLLocationCoordinate2D?, _ error: Error?)-> ()) {
        CLGeocoder().geocodeAddressString(string) { (placemark, error) in
            handler(placemark?.first?.location?.coordinate, error)
        }
    }
    
    //add weather icon fuctionality
     func setImageRelativeTo(daytime: String, temp: Int) -> UIImage? {
        if daytime == "n" &&  15...100 ~= temp  {
            let summerNight = UIImage(named: "summerNight")
            return summerNight
        } else if daytime == "d" &&  15...100 ~= temp {
            let summerDay = UIImage(named: "summer")
            return summerDay
        } else if daytime == "d" &&  -100...15 ~= temp {
            let witherDay = UIImage(named: "winter")
            return witherDay
        } else if daytime == "n" &&  -100...15 ~= temp {
            let winterNight = UIImage(named: "winterNight")
            return winterNight
        }
        return nil
    }
    
    
    
    
    
    
    
}
