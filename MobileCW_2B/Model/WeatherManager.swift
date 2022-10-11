//
//  WeatherManager.swift
//  MobileCW_2B
//
//  Created by Randimal Geeganage on 2022-05-20.
//

import Foundation

enum WeatherUnit: String, Equatable {
    case metric = "metric"
    case imperial = "imperial"
}

class WeatherManager : ObservableObject { //Curentbase URL
    let currentWeatherBaseURL: String = "https://api.openweathermap.org/data/2.5/weather?appid=\(API.key)"
    
    //onCallBase URL
    let oneCallBaseURL: String = "https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,minutely&appid=\(API.key)"
    
    // Lat and lon of Walasmulla
    let lat = 6.146966
    let lon = 80.697278
    
    @Published var weather: WeatherModel?
    private var unit: WeatherUnit = .metric
    
    
    func fetchForCurrentLocation() async {
        let url = "\(currentWeatherBaseURL)&lat=\(lat)&lon=\(lon)&units=metric"
        print(url)
        
        await requestWeather(url: url)
    }
    
    
    func fetchForCity(string: String, unit: WeatherUnit) async {
        self.unit = unit
        let url = "\(currentWeatherBaseURL)&q=\(string)&units=\(unit.rawValue)"
        print(url)
        
        await requestWeather(url: url)
    }
    
    
    func getFiveDayForecast(unit: WeatherUnit) {
        let url = "\(oneCallBaseURL)&lat=\(lat)&lon=\(lon)&units=\(unit.rawValue)"
    }
    
    
    func requestOneCallForecast(url: String) async {
        guard let url = URL(string: url) else { return }
        do {
            // Define a session for URL
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // JSON  response to swift object
            let weather =  try JSONDecoder().decode(WeatherData.self, from: data)
            DispatchQueue.main.async {
                self.weather = WeatherModel(id: weather.weather.first?.id ?? 0,
                                            name: weather.name,
                                            temperature: weather.main.temp,
                                            description: weather.weather.first?.description ?? "",
                                            humidity: weather.main.humidity,
                                            pressure: weather.main.pressure,
                                            windSpeed: weather.wind.speed,
                                            direction: weather.wind.deg,
                                            cloudPercentage: weather.clouds.all,
                                            unit: self.unit)
            }
            print(weather)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func requestWeather(url: String) async {
        guard let url = URL(string: url) else { return }
        do {
            // Define a session for URL
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // JSON  response to swift object
            let weather =  try JSONDecoder().decode(WeatherData.self, from: data)
            DispatchQueue.main.async {
                self.weather = WeatherModel(id: weather.weather.first?.id ?? 0,
                                            name: weather.name,
                                            temperature: weather.main.temp,
                                            description: weather.weather.first?.description ?? "",
                                            humidity: weather.main.humidity,
                                            pressure: weather.main.pressure,
                                            windSpeed: weather.wind.speed,
                                            direction: weather.wind.deg,
                                            cloudPercentage: weather.clouds.all,
                                            unit: self.unit)
            }
            print(weather)
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

