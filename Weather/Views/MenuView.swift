import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel = CityViewModel()
    @State private var cityName: String = ""
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                TextField("Search for city", text: $cityName, onCommit: {
                    viewModel.searchCity(cityName: cityName)
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .leading, .trailing], 10)

            }.padding()
            
            
            VStack {
                List (viewModel.cities) { city in
                    HStack {
                        Text(city.name)
                        Spacer()
                        Button(action: {
                            viewModel.addCity(city: city)
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
                .padding(0)
                .scrollContentBackground(.hidden)
            }
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.550, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
        .navigationTitle("Search City")

        

    }
    
}

class MockCityViewModel: CityViewModel {
    override init() {
        super.init()
        self.cities = [
            City(id: 1, name: "Berlin", latitude: 52.52437, longitude: 13.41053),
            City(id: 2, name: "Paris", latitude: 48.8566, longitude: 2.3522)
        ]
    }
}

#Preview {
    MenuView(viewModel: MockCityViewModel())
}
