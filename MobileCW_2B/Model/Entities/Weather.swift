//
//  Weather.swift
//  MobileCW_2B
//
//  Created by Randimal Geeganage on 2022-05-20.
//

import Foundation

struct WeatherData : Decodable{
    let name: String
    let weather: [Weather]
    let main: Main
    let clouds: Clouds
    let wind: Wind
}

struct Main: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
    let description: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct Clouds: Decodable {
    let all: Int
}
