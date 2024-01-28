import Foundation

class GeocodingService {
    func fetchCoordinates(cityName: String, completion: @escaping (Result<[City], Error>) -> Void) {
        let urlString = "https://geocoding-api.open-meteo.com/v1/search?name=\(cityName)&count=10&language=en&format=json"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                completion(.success(searchResults.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
