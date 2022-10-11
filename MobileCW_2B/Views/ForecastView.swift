//
//  ForecastView.swift
//  MobileCW_2B
//
//  Created by Randimal Geeganage on 2022-05-20.
//

import SwiftUI

struct ForecastView: View {
    @State private var unit: WeatherUnit = .metric
    @StateObject private var manager = OneCallWeatherManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $unit) {
                    Text("°C")
                        .tag(WeatherUnit.metric)
                    Text("°F")
                        .tag(WeatherUnit.imperial)
                }
                .pickerStyle(.segmented)
                .padding(EdgeInsets(top: 10, leading: 70, bottom: 0, trailing: 70))
                if  let data = manager.weather?.forecast{
                    List (0..<6) { index in
                        let item = data[index]
                        Section ("\(item.dt)") {
                            HStack(spacing: 20) {
                                Image(systemName: item.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.cyan)
                                VStack (alignment: .leading) {
                                    Text(item.weather.description)
                                    Text("\(item.temp)")
                                    HStack {
                                        Image(systemName: "cloud.fill").foregroundColor(.gray)
                                        Text("\(item.clouds)")
                                    }
                                    HStack {
                                        Image(systemName: "drop")
                                            .foregroundColor(.gray)
                                        Text("\(item.wind_speed)")
                                    }
                                   
                                    Text("Humidity:\(item.humidity)")
                                }
                            }
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                        }
                    }
                    .listStyle(.automatic)
                    .onChange(of: unit){ _ in
                        Task{
                            await manager.getFiveDayForecast(unit: self.unit)
                        }
                    }
                }
            }
            .navigationTitle("Mobile Weather")
            .onAppear{
                Task {
                    await manager.getFiveDayForecast(unit: self.unit)
                }
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
