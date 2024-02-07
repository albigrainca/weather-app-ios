import SwiftUI

struct DailyForecastView: View {
    var decript: (description: String, iconName: String, pColor: Color, sColor: Color?)
    var dateString: String
    var minTemp: Double
    var maxTemp: Double
    
    var body: some View {
        HStack {
            Text(dayOfWeek(from: dateString))
                .font(.headline)
                .frame(width: 60)
            Spacer()
            
            Image(systemName: decript.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(decript.pColor, decript.sColor ?? .clear)
            
            Spacer()
            
            HStack {
                Text("\(minTemp, specifier: "%.1f")°")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("-")
                    .font(.subheadline)
                Text("\(maxTemp, specifier: "%.1f")°")
                    .font(.subheadline)
            }                
            .frame(width: 90)

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
