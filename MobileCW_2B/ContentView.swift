//
//  ContentView.swift
//  MobileCW_2B
//
//  Created by Randimal Geeganage on 2022-05-20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchView()
                .tabItem {
                    Label("Current", systemImage: "magnifyingglass")
                }
            ForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "goforward")
                }
            IntervalWeatherView()
                .tabItem {
                    Label("Intervals", systemImage: "deskclock")
                }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
