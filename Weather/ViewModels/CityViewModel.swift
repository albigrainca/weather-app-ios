//  CityViewModel.swift
//
//  Created by Albi GRAINCA and Batuhan GOKER
//

import SwiftUI

class CityViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var savedCities: [City] = []
    private var geocodingService = GeocodingService()
    @Published var isShowingMenuView = false
    @Published var selectedWeatherData: WeatherData?
    private var weatherService = WeatherService()
    
    func searchCity(cityName: String) {
        Task {
            do {
                let searchResults = try await geocodingService.fetchCoordinates(cityName: cityName)
                DispatchQueue.main.async {
                    self.cities = searchResults.results
                }
            } catch {
                print(error)
            }
        }
    }
    
    func addCity(city: City) {
        if !savedCities.contains(where: { $0.id == city.id }) {
            savedCities.append(city)
        }
    }
    
    func deleteCity(at offsets: IndexSet) {
        savedCities.remove(atOffsets: offsets)
    }
    
    func fetchWeatherData(for city: City) {
        Task {
            do {
                let weatherData = try await WeatherService().fetchWeatherData(latitude: city.latitude, longitude: city.longitude)
                let modifiedWeatherData = await prepareWeatherData(weatherData)
                DispatchQueue.main.async {
                    self.selectedWeatherData = modifiedWeatherData
                }
            } catch {
                print(error)
            }
        }
    }

    private func prepareWeatherData(_ weatherData: WeatherData) async -> WeatherData {
        var modifiedWeatherData = weatherData
        
        // Conversion et filtrage des données
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "HH"

        if let currentTime = inputDateFormatter.date(from: weatherData.currentWeather.time) {
            let hourlyTimes = weatherData.hourly.time.compactMap { inputDateFormatter.date(from: $0) }
            let filteredIndices = hourlyTimes.enumerated().filter({ $0.element >= currentTime }).map({ $0.offset })

            modifiedWeatherData.hourly.time = filteredIndices.map { outputDateFormatter.string(from: hourlyTimes[$0]) }
            
            modifiedWeatherData.hourly.temperature_2m = filteredIndices.map { weatherData.hourly.temperature_2m[$0] }
            modifiedWeatherData.hourly.weather_code = filteredIndices.map { weatherData.hourly.weather_code[$0] }
        }
        return modifiedWeatherData
    }

    
    func decriptWeatherCode(_ code: Int) -> (description: String, iconName: String, pColor: Color, sColor: Color?) {
        switch code {
        case 0:
            return ("Clear Sky", "sun.max.fill", .yellow, nil)
        case 1...3:
            return ("Partly Cloudy", "cloud.sun.fill", .white, .yellow)
        case 4...48:
            return ("Fog", "cloud.fog.fill", .white, .gray)
        case 49...55:
            return ("Drizzle", "cloud.drizzle.fill", .white, .blue)
        case 56...57:
            return ("Freezing Drizzle", "cloud.sleet.fill", .white, .blue)
        case 58...60:
            return ("Rain", "cloud.heavyrain.fill", .white, .blue)
        case 61...65:
            return ("Rain", "cloud.rain.fill", .white, .blue)
        case 66...67:
            return ("Freezing Rain", "cloud.sleet.fill", .white, .blue)
        case 68...75:
            return ("Snow", "snow", .white, nil)
        case 76...77:
            return ("Snow", "wind.snow", .gray, .white)
        case 78...79:
            return ("Rain and Snow", "cloud.sleet.fill", .blue, .white)
        case 80...84:
            return ("Rain Showers", "cloud.rain.fill", .white, .blue)
        case 85...86:
            return ("Snow Showers", "cloud.snow.fill", .white, .white)
        case 87...94:
            return ("Extreme Weather", "tornado", .gray, nil)
        case 95...99:
            return ("Thunderstorm", "cloud.bolt.rain.fill", .white, .blue)
        default:
            return ("Unknown", "questionmark.diamond.fill", .black, .white)
        }
    }

}
