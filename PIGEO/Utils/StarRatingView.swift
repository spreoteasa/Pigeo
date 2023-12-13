//
//  StarRatingView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 19.11.2023.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: index < self.rating ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.lightPurple)
                    .onTapGesture {
                        self.rating = index + 1
                    }
            }
        }
        .animation(.default, value: rating)
        .padding()
    }
}

#Preview {
    StarRatingView(rating: .constant(3))
}
