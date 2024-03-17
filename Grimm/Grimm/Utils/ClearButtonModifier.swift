//
//  ClearButtonModifier.swift
//  Grimm
//
//  Created by Brian Jiménez Moedano on 17/03/24.
//

import SwiftUI

struct ClearButtonModifier: ViewModifier {
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

