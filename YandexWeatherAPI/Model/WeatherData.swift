//
//  WeatherData.swift
//  YandexWeatherAPI
//
//  Created by Admin on 11.01.2021.
//  Copyright © 2021 DmitryChaschin. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let fact: Fact
    let geoObject: GeoObject
    
    enum CodingKeys: String, CodingKey {
        case geoObject = "geo_object"
        case fact
    }
}

struct Fact: Codable {
    let temp: Int
    let condition: Condition
    let pressureMm: Int
    let feelsLike : Int
    let daytime: Daytime
    
    enum CodingKeys: String, CodingKey {
        case pressureMm = "pressure_mm"
        case condition
        case temp
        case feelsLike = "feels_like"
        case daytime
    }
}

enum Daytime:String, Codable {
    case d = "d"
    case n = "n"
}

struct GeoObject: Codable {
    let province: Country
    let district: Country
    let country : Country
}

struct Country: Codable {
    let name: String
}

enum Condition: String, Codable {
    case clear = "clear"
    case cloudy = "cloudy"
    case lightSnow = "light-snow"
    case overcast = "overcast"
    case snow = "snow"
    case partlyCloudy = "partly-cloudy"
    case drizzle = "drizzle"
    case lightRain = "light-rain"
    case rain = "rain"
    case moderateRain = "moderate-rain"
    case heavyRain = "heavy-rain"
    case continuousHeavyRain = "continuous-heavy-rain"
    case showers = "showers"
    case wetSnow = "wet-snow"
    case snowShowers = "snow-showers"
    case hail = "hail"
    case thunderstorm = "thunderstorm"
    case thunderstormWithRain = "thunderstorm-with-rain"
    case thunderstormWithHail = "thunderstorm-with-hail"
}
