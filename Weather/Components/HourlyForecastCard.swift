import SwiftUI

struct HourlyForecastCard: View {
    var decript: (description: String, iconName: String, pColor: Color, sColor: Color?)
    var dateTimeString: String
    var temperature: Double
    
    var body: some View {
        VStack {
            Text(dateTimeString)
                .font(.caption)
            Image(systemName: decript.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundStyle(decript.pColor, decript.sColor ?? .clear)
            Text("\(temperature, specifier: "%.1f")°")
                .font(.caption)
        }
        .frame(width: 80, height: 100)
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
}
