//
//  CreateEventView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import SwiftUI

struct CreateEventView: View {
    @State var event = Event(id: 0, name: "", description: "", creator: "", rated: false, adminList: [""], attendees: [""], activities: [], todos: [])
    let create: (Event) -> Void
    var body: some View {
        VStack(spacing: 0) {
            PGTextField(image: Image("omulet"), name: "Name", isSecure: false, field: $event.name)
                .padding(.bottom, 16)
            PGTextField(image: Image("tiles"), name: "Event Description", isSecure: false, field: $event.description)
                .foregroundStyle(Color.init(hex: "#B9B9C7"))
                .padding(.bottom, 16)
            
            Button {
                create(event)
            } label: {
                Text("Create")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 67)
                    .padding(.vertical, 8)
                    .background(Color.init(hex: "#7C7CD3"), in: RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            ZStack {
                Image("poza-mare")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Color(hex: "#200D2F")
                    .opacity(0.6)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle("Create")
            
        }
    }
}

#Preview {
    CreateEventView() { _ in }
}
