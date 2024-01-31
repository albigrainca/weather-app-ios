import SwiftUI

struct DailyForecastView: View {
    var dateString: String
    var minTemp: Double
    var maxTemp: Double
    
    var body: some View {
        HStack {
            Text(dayOfWeek(from: dateString))
                .font(.headline)
            Spacer()
            Text("\(minTemp, specifier: "%.1f")° - \(maxTemp, specifier: "%.1f")°")
                .font(.subheadline)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    func dayOfWeek(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
}
