import SwiftUI

struct HourlyWeatherView: View {
    var dateTimeString: String
    var weatherCode: Int
    var temperature: Double
    
    var body: some View {
        VStack {
            Text(formatHour(from: dateTimeString)) // Affiche seulement l'heure
                .font(.caption)
            Image(systemName: iconNameForWeatherCode(weatherCode)) // Utilise l'icône correspondante
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text("\(temperature, specifier: "%.1f")°") // La température
                .font(.caption)
        }
        .frame(width: 80, height: 100)
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
    
    func formatHour(from dateTimeString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm" // Format d'entrée
        guard let date = dateFormatter.date(from: dateTimeString) else { return "" }
        
        dateFormatter.dateFormat = "HH" // Format de sortie (heure uniquement)
        return dateFormatter.string(from: date)
    }
    
    func iconNameForWeatherCode(_ code: Int) -> String {
        switch code {
            case 0: return "sun.max" // Clear Sky
            case 1: return "cloud.sun" // Partly cloudy
            case 2: return "cloud.snow" // Blowing snow
            case 3: return "tornado" // Sandstorm
            case 4: return "cloud.fog" // Fog
            case 5: return "cloud.drizzle" // Drizzle
            case 6: return "cloud.rain" // Rain
            case 7: return "snow" // Snow
            case 8: return "cloud.heavyrain" // Shower
            case 9: return "cloud.bolt.rain" // Thunderstorm
            default: return "questionmark.diamond" // Unknown
        }
    }
}
