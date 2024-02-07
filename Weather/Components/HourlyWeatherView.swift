import SwiftUI

struct HourlyWeatherView: View {
    var dateTimeString: String
    var weatherCode: Int
    var temperature: Double
    
    var body: some View {
        VStack {
            Text(dateTimeString)
                .font(.caption)
            let (iconName, pColor, sColor) = getIcon(weatherCode)
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundStyle(pColor, sColor ?? .clear)
            Text("\(temperature, specifier: "%.1f")°")
                .font(.caption)
        }
        .frame(width: 80, height: 100)
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
    
    func getIcon(_ code: Int) -> (iconName: String, pColor: Color, sColor: Color?) {
        switch code {
        case 0:
            return ("sun.max.fill", .yellow, nil)
        case 1...3:
            return ("cloud.sun.fill", .white, .yellow)
        case 4...48:
            return ("cloud.fog.fill", .white, .gray)
        case 49...55:
            return ("cloud.drizzle.fill", .white, .blue)
        case 56...57:
            return ("cloud.sleet.fill", .white, .blue)
        case 58...60:
            return ("cloud.heavyrain.fill", .white, .blue)
        case 61...65:
            return ("cloud.rain.fill", .white, .blue)
        case 66...67:
            return ("cloud.sleet.fill", .white, .blue)
        case 68...75:
            return ("snow", .white, nil)
        case 76...77:
            return ("wind.snow", .gray, .white)
        case 78...79:
            return ("cloud.sleet.fill", .blue, .white)
        case 80...84:
            return ("cloud.rain.fill", .white, .blue)
        case 85...86:
            return ("cloud.snow.fill", .white, .white)
        case 87...94:
            return ("tornado", .gray, nil)
        case 95...99:
            return ("cloud.bolt.rain.fill", .white, .blue)
        default:
            return ("questionmark.diamond.fill", .black, .white)
        }
    }

}
