//  CitiesView.swift
//
//  Created by Albi GRAINCA and Batuhan GOKER
//

import SwiftUI

struct CitiesView: View {
    @ObservedObject var viewModel = CityViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    ForEach(viewModel.savedCities) { city in
                        NavigationLink(destination: WeatherView(viewModel: viewModel, city: city)) {
                            VStack(alignment: .leading) {
                                Text(city.name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .frame(height: 50)
                        }
                        .listRowBackground(Color.white.opacity(0.1))
                    }
                    .onDelete(perform: viewModel.deleteCity)
                }
                .padding(.top, 1)
                .scrollContentBackground(.hidden)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hue: 0.550, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
            .navigationTitle("Cities List")
            .navigationBarItems(trailing:
                NavigationLink(destination: SearchView(viewModel: viewModel)) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            )
        }
    }
}


class MockCity: CityViewModel {
    override init() {
        super.init()
        self.savedCities = [
            City(id: 1, name: "Berlin", latitude: 52.52437, longitude: 13.41053),
            City(id: 2, name: "Paris", latitude: 48.8566, longitude: 2.3522)
        ]
    }
}


#Preview {
    CitiesView(viewModel: MockCity())
}
