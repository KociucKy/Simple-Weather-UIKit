//
//  ForecastData.swift
//  Simple Weather App
//
//  Created by Kuba Kociucki on 01/10/2021.
//

import Foundation

struct ForecastData: Codable{
    let list: [ForecastList]
}

struct ForecastList: Codable{
    let dt_txt: String
    let main: ForecastMain
    let weather: [ForecastWeather]
}

struct ForecastMain: Codable{
    let temp: Double
}

struct ForecastWeather: Codable{
    let id: Int
}
