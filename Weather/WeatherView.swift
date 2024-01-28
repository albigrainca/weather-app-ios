import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack (alignment: .leading) {
            VStack {
                VStack (alignment: .center, spacing: 5) {
                    Text("Mulhouse")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("9°")
                        .font(.system(size: 100))
                        .fontWeight(.bold)
                    Text ("Cloudy")
                        .font(.title2)
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                
                
                VStack (alignment: .center, spacing: 5) {
                    VStack(alignment: .leading, spacing: 20) {

                        HStack {
                            RangeDegreeRow(logo: "thermometer", name: "Min temp", value: "9°")
                            Spacer()
                            RangeDegreeRow(logo: "thermometer", name: "Max temp", value: "11°")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(Color(hue: 0.375, saturation: 0.5, brightness: 0.7))

                .cornerRadius(20)
                .padding(.horizontal)


                
                VStack {
                    List {
                        HStack {
                            Text("Today")
                            Spacer()
                            Text("9°")
                        }
                        HStack {
                            Text("Today")
                            Spacer()
                            Text("9°")
                        }
                        HStack {
                            Text("Today")
                            Spacer()
                            Text("9°")
                        }
                        HStack {
                            Text("Today")
                            Spacer()
                            Text("9°")
                        }
                        HStack {
                            Text("Today")
                            Spacer()
                            Text("9°")
                        }
                        HStack {
                            Text("Today")
                            Spacer()
                            Text("9°")
                        }
                        HStack {
                            Text("Today")
                            Spacer()
                            Text("9°")
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.550, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)

    }
}

#Preview {
    WeatherView()
}
