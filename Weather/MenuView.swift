import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                Text("Weather")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)

                TextField("Search for city", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .leading, .trailing], 10)

            }.padding()
            
            
            VStack {
                List {
                    Text("Mulhouse")
                    Text("Mulhouse")
                }
                .padding(0)
                .scrollContentBackground(.hidden)
            }
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.550, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)

        

    }
    
}

#Preview {
    MenuView()
}
