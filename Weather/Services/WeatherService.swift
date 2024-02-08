//  WeatherService.swift
//
//  Created by Albi GRAINCA and Batuhan GOKER
//

import Foundation

class WeatherService {
    func fetchWeatherData(latitude: Double, longitude: Double) async throws -> WeatherData {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&current_weather=true"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "InvalidURL", code: 1, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        return weatherData
    }
}
