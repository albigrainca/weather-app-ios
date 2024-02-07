import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = CityViewModel()
    @State private var cityName: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            VStack {
                TextField("Search for city", text: $cityName, onCommit: {
                    viewModel.searchCity(cityName: cityName)
                })
                .frame(width: UIScreen.main.bounds.width * 0.85, height: 35)
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.5))
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding()
            
            ScrollView(.vertical) {
                if !viewModel.cities.isEmpty {
                    VStack(spacing: 20) {
                        ForEach(viewModel.cities) { city in
                            HStack {
                                Text(city.name)
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Button(action: {
                                    viewModel.addCity(city: city)
                                    presentationMode.wrappedValue.dismiss()
                                    
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                                .padding()
                            }
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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
    SearchView(viewModel: MockCityViewModel())
}

