//
//  WeatherModel.swift
//  YandexWeatherAPI
//
//  Created by Admin on 11.01.2021.
//  Copyright © 2021 DmitryChaschin. All rights reserved.
//

import Foundation

struct WeatherModel {
    let temperature: Int
    let name: String
    let codition: String
    let pressure : String
    let feelsLike : String
    let daytime : String
    var conditionIcon: String {
        if daytime == "d"{
        switch codition {
        case "clear": return "sun.max.fill"
        case "cloudy": return  "cloud.fill"
        case "lightSnow": return  "cloud-snow"
        case "overcast": return  "smoke.fill"
        case "snow": return "snow"
        case "partlyCloudy": return "cloud.sun"
        case "drizzle" : return "cloud.drizzle"
        case "lightRain": return "cloud.drizzle"
        case "rain": return "cloud.rain"
        case "moderateRain": return "cloud.rain"
        case "heavyRain": return "cloud.heavyrain"
        case "continuousHeavyRain": return "cloud.heavyrain"
        case "showers": return "cloud.heavyrain"
        case "wetSnow": return "cloud.sleet"
        case "snowShowers": return "cloud.sleet"
        case "hail":return "cloud.hail"
        case "thunderstorm" : return"smoke.fill"
        case "thunderstormWithRain": return "cloud.bolt.rain"
        case "thunderstormWithHail": return "cloud.bolt.rain"
        default: return  "cloud.fill"
        }
        } else {
            switch codition {
            case "clear": return "moon.stars.fill"
            case "cloudy": return  "cloud.moon.fill"
            case "lightSnow": return  "cloud-snow"
            case "overcast": return  "smoke.fill"
            case "snow": return "snow"
            case "partlyCloudy": return "cloud.moon.fill"
            case "drizzle" : return "cloud.moon.rain"
            case "lightRain": return "cloud.moon.rain"
            case "rain": return "cloud.moon.rain"
            case "moderateRain": return "cloud.moon.rain"
            case "heavyRain": return "cloud.moon.rain"
            case "continuousHeavyRain": return "cloud.moon.rain"
            case "showers": return "cloud.moon.rain"
            case "wetSnow": return "cloud.sleet"
            case "snowShowers": return "cloud.sleet"
            case "hail":return "cloud.hail"
            case "thunderstorm" : return"cloud.moon.bolt.fill"
            case "thunderstormWithRain": return "cloud.bolt.rain"
            case "thunderstormWithHail": return "cloud.bolt.rain"
            default: return  "cloud.fill"
            }
        }
    }
    
    
    
}
