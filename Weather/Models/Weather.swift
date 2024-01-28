import Foundation

struct CurrentWeather: Codable {
    let time: String
    let temperature: Double
    let windspeed: Double
    let winddirection: Int
    let weathercode: Int
}

struct DailyWeather: Codable {
    let time: [String]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
}


struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currentWeather: CurrentWeather
    let daily: DailyWeather
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case currentWeather = "current_weather"
        case daily
    }
    
    enum DailyCodingKeys: String, CodingKey {
        case time
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
    }
}

