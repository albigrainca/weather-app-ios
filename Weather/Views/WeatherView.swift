import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: CityViewModel
    let city: City
    
    var body: some View {
        ScrollView {
            if viewModel.selectedWeatherData == nil {
                VStack {
                    Text("Loading...")
                        .font(.title2)
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .center)

            } else {
                VStack (alignment: .center, spacing: 5) {
                    Text(city.name)
                        .font(.title)
                        .fontWeight(.bold)
                    if let currentWeather = viewModel.selectedWeatherData?.currentWeather {
                        Text("\(currentWeather.temperature, specifier: "%.1f")°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                        Text("\(viewModel.descriptionForWeatherCode(currentWeather.weathercode))")
                            .font(.title2)
                        if let dailyWeather = viewModel.selectedWeatherData?.daily,
                           let tempMin = dailyWeather.temperature_2m_min.first,
                           let tempMax = dailyWeather.temperature_2m_max.first {
                            HStack(spacing: 10) {
                                Text("H:\(tempMax, specifier: "%.1f")°")
                                    .font(.headline)
                                Text("L:\(tempMin, specifier: "%.1f")°")
                                    .font(.headline)
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                
                
                VStack {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.white)
                        Text("HOURLY FORECAST")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.top, 8)
                    
                    if let hourlyWeather = viewModel.selectedWeatherData?.hourly {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 13) {
                                ForEach(Array(zip(hourlyWeather.time.indices, zip(hourlyWeather.temperature_2m, hourlyWeather.weather_code))).prefix(20), id: \.0) { index, data in
                                    let (temperature, weatherCode) = data
                                    HourlyWeatherView(dateTimeString: hourlyWeather.time[index], weatherCode: weatherCode, temperature: temperature)
                                }
                            }
                            .padding(.horizontal, 10.0)
                            
                        }
                        .frame(height: 120)
                        .padding(3)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding(3)
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.white)
                        Text("7-DAY FORECAST")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    if let dailyWeather = viewModel.selectedWeatherData?.daily {
                        VStack {
                            ForEach(Array(zip(dailyWeather.time.indices, zip(dailyWeather.temperature_2m_min, dailyWeather.temperature_2m_max))), id: \.0) { index, temps in
                                let (minTemp, maxTemp) = temps
                                DailyForecastView(dateString: dailyWeather.time[index], minTemp: minTemp, maxTemp: maxTemp)
                                
                                if index != dailyWeather.time.count - 1 {
                                    Divider().background(Color.white)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            
        }
        .padding(3)
        .frame(maxWidth: .infinity, alignment: .center)
        .edgesIgnoringSafeArea(.bottom)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.white.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
        .preferredColorScheme(.dark)
        .onAppear { viewModel.fetchWeatherData(for: city) }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("", displayMode: .inline)
    }

}


#Preview {
    WeatherView(viewModel: CityViewModel(), city: City(id: 1, name: "Sample City", latitude: 5.0, longitude: 0.0))
               .preferredColorScheme(.dark)
}
