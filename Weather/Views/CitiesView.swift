import SwiftUI

struct CitiesView: View {
    @ObservedObject var viewModel = CityViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ForEach(viewModel.savedCities) { city in
                            NavigationLink(destination: WeatherView(viewModel: viewModel, city: city)) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(city.name)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hue: 0.550, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
            .navigationTitle("Cities List")
            .navigationBarItems(trailing:
                NavigationLink(destination: SearchView(viewModel: viewModel)) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            )
        }
    }
}


class MockCity: CityViewModel {
    override init() {
        super.init()
        self.savedCities = [
            City(id: 1, name: "Berlin", latitude: 52.52437, longitude: 13.41053),
            City(id: 2, name: "Paris", latitude: 48.8566, longitude: 2.3522)
        ]
    }
}

#Preview {
    CitiesView(viewModel: MockCity())
}
