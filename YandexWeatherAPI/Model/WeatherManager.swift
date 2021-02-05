//
//  WeatherManager.swift
//  YandexWeatherAPI
//
//  Created by Admin on 11.01.2021.
//  Copyright © 2021 DmitryChaschin. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherDataDelegate {
    func updateData(_ withManager:WeatherManager, withModel:WeatherModel)
}

struct WeatherManager {
    private let baseUrl = "https://api.weather.yandex.ru/v2/forecast?"
    private let apiKey = "96497bb1-ddbb-4d33-b45b-e7961ac086be"
    private let httpHeader = "X-Yandex-API-Key"
    var delegate:WeatherDataDelegate?
    
    func fechWeather(from coordinate: CLLocationCoordinate2D ) {
        var lattitude = coordinate.latitude
        var longitude = coordinate.longitude
        let urlString = "\(baseUrl)&lat=\(lattitude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: .infinity)
        urlRequest.addValue(apiKey, forHTTPHeaderField: httpHeader)
        urlRequest.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { (data, responce, error) in
            if error != nil {
                print("fetchWeather-ERROR\(error!)")
                return
            }
            if let safeData = data {
                if let weather = self.parseJSON(weatherData: safeData) {
                    self.delegate?.updateData(self, withModel: weather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temperature = decodedData.fact.temp
            let cityName = decodedData.geoObject.district.name
            let condition = decodedData.fact.condition
            let pressure = String(decodedData.fact.pressureMm)
            let feelsLike = String(decodedData.fact.feelsLike)
            let daytime = decodedData.fact.daytime
            let weatherModel = WeatherModel(temperature: temperature, name: cityName, codition: condition.rawValue, pressure: pressure, feelsLike:feelsLike,daytime:daytime.rawValue)
            return weatherModel
        } catch {
            print("parseJSON-ERROR\(error)")
        }
        return nil
    }
    
    
    
}
