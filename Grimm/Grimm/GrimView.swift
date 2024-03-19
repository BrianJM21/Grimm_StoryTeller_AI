//
//  GrimmView.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 06/03/24.
//

import SwiftUI

struct GrimView: View {
    
    @AppStorage("savedTale")
    private var savedTale = ""
    
    @State private var tabIndex: Int = 0
    @State var taleToSave = ""
    
    var body: some View {
        TabView(selection: $tabIndex) {
            GenTaleView(taleToSave: $taleToSave)
                .tag(0)
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Genera Cuento")
                }
            Text(savedTale.isEmpty ? "No tienes cuentos guardados" : savedTale)
                .tag(1)
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Biblioteca")
                }
        }
        .onChange(of: taleToSave) { taleToSave in
            savedTale = taleToSave
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    GrimView()
}
