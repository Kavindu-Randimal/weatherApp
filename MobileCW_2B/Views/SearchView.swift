//
//  SearchView.swift
//  MobileCW_2B
//
//  Created by Randimal Geeganage on 2022-05-20.
//

import SwiftUI

struct SearchView: View {
    @State private var cityText = ""
    @State private var unitToggle = false
    
    @StateObject var manager = WeatherManager()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter a city", text: $cityText)
                    .textFieldStyle(.roundedBorder)
                Button {
                    Task {
                        await manager.fetchForCity(string: self.cityText, unit: unitToggle ? .imperial : .metric)
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .padding()
                }
            }
            Toggle(isOn: $unitToggle) {
                Text("Is Imperial?")
            }
            .frame(width: 200)
            .padding()
            .font(.system(size: 20, weight: .medium, design: .rounded))
            if let data = manager.weather?.detailedData {
                List(data) { item in
                    HStack {
                        Image(systemName: item.icon)
                            .foregroundColor(item.color)
                        Text(item.title)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                        Spacer()
                        Text("\(item.value)")
                            .font(.system(size: 20, weight: .bold, design: .rounded)) + Text(item.unit)
                            .font(.system(size: 16, weight: .light, design: .rounded))
                    }
                }
                .listStyle(.automatic)
            }
            else {
                Spacer()
            }
        }
        .onChange(of: unitToggle, perform: { _ in
            Task {
                print("dsfadf")
                await manager.fetchForCity(string: self.cityText, unit: unitToggle ? .imperial : .metric)
            }
        })
        .padding()
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
