import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: CityViewModel
    let city: City
    
    var body: some View {
        ZStack (alignment: .leading) {
            VStack {
                VStack (alignment: .center, spacing: 5) {
                    Text(city.name)
                        .font(.title)
                        .fontWeight(.bold)
                    if let currentWeather = viewModel.selectedWeatherData?.currentWeather {
                        Text("\(currentWeather.temperature, specifier: "%.1f")°") // Température actuelle
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                        Text("\(viewModel.descriptionForWeatherCode(currentWeather.weathercode))")
                            .font(.title2)
                    } else {
                        Text("Loading...") // Afficher pendant le chargement des données
                            .font(.title2)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                

                
                VStack {
                    List {
                        Section {
                            if let dailyWeather = viewModel.selectedWeatherData?.daily,
                               let tempMin = dailyWeather.temperature_2m_min.first,
                               let tempMax = dailyWeather.temperature_2m_max.first {
                                let formattedMinTemp = String(format: "%.1f°", tempMin)
                                let formattedMaxTemp = String(format: "%.1f°", tempMax)

                                VStack(alignment: .leading, spacing: 20) {
                                    HStack {
                                        RangeDegreeRow(logo: "thermometer", name: "Min temp", value: formattedMinTemp)
                                        Spacer()
                                        RangeDegreeRow(logo: "thermometer", name: "Max temp", value: formattedMaxTemp)
                                    }
                                }
                            } else {
                                Text("Loading weather data...")
                            }
                        }.listRowBackground(Color(hue: 0.375, saturation: 0.5, brightness: 0.7))
                        
                        Section {
                            if let dailyWeather = viewModel.selectedWeatherData?.daily {
                                ForEach(Array(zip(dailyWeather.time.indices, zip(dailyWeather.temperature_2m_min, dailyWeather.temperature_2m_max))), id: \.0) { index, temps in
                                    let (minTemp, maxTemp) = temps
                                    HStack {
                                        Text(dayOfWeek(from: dailyWeather.time[index]))
                                        Spacer()
                                        Text("\(minTemp, specifier: "%.1f")° - \(maxTemp, specifier: "%.1f")°")
                                    }
                                }
                            } else {
                                Text("Loading weather data...")
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .edgesIgnoringSafeArea(.bottom)
                .background(Color(hue: 0.550, saturation: 0.787, brightness: 0.354))
                .preferredColorScheme(.dark)
                .onAppear { viewModel.fetchWeatherData(for: city) }



                
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.550, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
        .onAppear { viewModel.fetchWeatherData(for: city) }
    }
    
    func dayOfWeek(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }

}


#Preview {
    WeatherView(viewModel: CityViewModel(), city: City(id: 1, name: "Sample City", latitude: 0.0, longitude: 0.0))
               .preferredColorScheme(.dark)
}

