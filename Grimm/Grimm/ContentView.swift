//
//  ContentView.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 06/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var tabIndex: Int = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            GenTaleView()
                .tag(0)
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Gen a Tale")
                }
            Text("Tab Content 2")
                .tag(1)
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Saved Tales")
                }
        }
    }
}

#Preview {
    ContentView()
}
