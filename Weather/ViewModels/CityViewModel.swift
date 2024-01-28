import SwiftUI

class CityViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var savedCities: [City] = []
    private var geocodingService = GeocodingService()
    @Published var isShowingMenuView = false
    @Published var selectedWeatherData: WeatherData?
    private var weatherService = WeatherService()
    
    func searchCity(cityName: String) {
        geocodingService.fetchCoordinates(cityName: cityName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cities):
                    self?.cities = cities
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func addCity(city: City) {
        if !savedCities.contains(where: { $0.id == city.id }) {
            savedCities.append(city)
        }
    }
    
    func fetchWeatherData(for city: City) {
        weatherService.fetchWeatherData(latitude: city.latitude, longitude: city.longitude) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    self?.selectedWeatherData = weatherData
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func descriptionForWeatherCode(_ code: Int) -> String {
        switch code {
        case 0: return "Clear Sky"
        case 1: return "Partly cloudy"
        case 2: return "Blowing snow"
        case 3: return "Sandstorm"
        case 4: return "Fog"
        case 5: return "Drizzle"
        case 6: return "Rain"
        case 7: return "Snow"
        case 8: return "Shower"
        case 9: return "Thunderstorm"
        default: return "Unknown"
        }
    }

}
