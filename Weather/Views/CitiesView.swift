import SwiftUI

struct CitiesView: View {
    @ObservedObject var viewModel = CityViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    List (viewModel.savedCities) { city in
                        NavigationLink(destination: WeatherView(viewModel: viewModel, city: city)) {
                            VStack(alignment: .leading) {
                                Text(city.name)
                                Text("Latitude: \(city.latitude)")
                                Text("Longitude: \(city.longitude)")
                            }
                        }
                    }
                    .padding(0)
                    .scrollContentBackground(.hidden)
                }
                Spacer()
                
                NavigationLink(destination: MenuView(viewModel: viewModel)) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add City")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                }.padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hue: 0.550, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
            .navigationTitle("Cities List")
            
        }
    }
    
}


#Preview {
    CitiesView()
}
