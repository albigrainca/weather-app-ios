import Foundation

class WeatherService {
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min&current_weather=true"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "WeatherService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "WeatherService", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                print(error)
                completion(.failure(error))
            }

        }.resume()
    }
}
