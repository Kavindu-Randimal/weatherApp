//
//  IntervalWeatherView.swift
//  MobileCW_2B
//
//  Created by Randimal Geeganage on 2022-05-20.
//

import SwiftUI

struct IntervalWeatherView: View {
    
    @State private var unit: WeatherUnit = .metric
    @StateObject private var manager = OneCallWeatherManager()
    
    var body: some View {
        VStack {
            if let data = manager.weather {
                if let current = data.current {
                    HStack {
                        Text(Date.now, style: .date)
                        Text("\(current.dt)")
                    }
                    Spacer(minLength: 10)
                    VStack {
                        Image(systemName: current.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                        Text(current.temp)
                            .font(.system(size: 60, weight: .black, design: .rounded))
                            .foregroundColor(.yellow)
                    }
                    Text("\(current.weather.description)")
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                }
                List (data.hourlyForecasts) { item in
                    HStack(spacing: 20) {
                        Image(systemName: item.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.cyan)
                        VStack (alignment: .leading) {
                            Text(item.weather.description)
                            Text(item.dt)
                        }
                        Spacer()
                        Text("\(item.temp)")
                    }
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                }
                .listStyle(PlainListStyle())
            } else {
                Spacer()
            }
        }
        .onAppear {
            Task {
                await manager.getFiveDayForecast(unit: self.unit)
            }
        }
    }
}
struct IntervalWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalWeatherView()
    }
}
