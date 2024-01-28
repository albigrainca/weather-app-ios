import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    var body: some View {
        VStack {
            MenuView()
        }
    }
}

#Preview {
    ContentView()
}
