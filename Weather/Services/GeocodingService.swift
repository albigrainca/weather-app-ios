import Foundation

class GeocodingService {
    func fetchCoordinates(cityName: String) async throws -> SearchResults {
        let urlString = "https://geocoding-api.open-meteo.com/v1/search?name=\(cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&count=10&language=en&format=json"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "InvalidURL", code: 1, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
        return searchResults
    }
}
