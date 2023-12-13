//
//  PGTextField.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 19.11.2023.
//

import SwiftUI

struct PGTextField: View {
    let image: Image
    let name: String
    let isSecure: Bool
    @Binding var field: String
    
    var body: some View {
        HStack {
            image
                .padding(9)
                .foregroundStyle(.textPrimary)
                .background(Color.init(hex: "#7C7CD3"))
            
            getField()
                .foregroundStyle(Color.init(hex: "#B9B9C7"))
        }
        .background(.clear)
        .border(Color.init(hex: "#7C7CD3"), width: 1)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.init(hex: "#7C7CD3"), lineWidth: 1)
        )
    }
    
    @ViewBuilder
    private func getField() -> some View {
        if isSecure {
            SecureField(text: $field, label: {
                Text(name)
                    .foregroundStyle(Color.init(hex: "#B9B9C7"))
            })
        }
        else {
            TextField(text: $field, label: {
                Text(name)
                    .foregroundStyle(Color.init(hex: "#B9B9C7"))
            })
        }
    }
}
