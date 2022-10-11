//
//  HomeView.swift
//  MobileCW_2B
//
//  Created by Randimal Geeganage on 2022-05-20.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var manager = WeatherManager()
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.top)
            VStack{
                Text(manager.weather?.name ?? "")
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                Text(manager.weather?.description ?? "")
                    .font(.system(size: 26, weight: .black, design: .rounded))
                Image(systemName: manager.weather?.conditionIcon ?? "cloud")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                Text("\(manager.weather?.tempString ?? "--")°C")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                
            }.foregroundColor(.white)
        }
        .onAppear{
            Task{
                await manager.fetchForCurrentLocation()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
