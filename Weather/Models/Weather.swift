import Foundation

struct CurrentWeather: Codable {
    let time: String
    let temperature: Double
    let windspeed: Double
    let winddirection: Int
    let weathercode: Int
}

struct HourlyWeather: Codable {
    var time: [String]
    var temperature_2m: [Double]
    var weather_code: [Int]
}

struct DailyWeather: Codable {
    let time: [String]
    var temperature_2m_max: [Double]
    var temperature_2m_min: [Double]
    var weather_code: [Int]
}


struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currentWeather: CurrentWeather
    var hourly: HourlyWeather
    var daily: DailyWeather
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case currentWeather = "current_weather"
        case daily
        case hourly
    }
    
    enum HourlyCodingKeys: String, CodingKey {
        case time
        case temperature_2m
        case weather_code
    }
    
    enum DailyCodingKeys: String, CodingKey {
        case time
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
        case weather_code
    }
}

