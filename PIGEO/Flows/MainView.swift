//
//  MainView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import SwiftUI
import Alamofire

let gray = Color.init(hex: "#A8A8A8")
let accent = Color.init(hex: "#452B5")
let lightPurple = Color.init(hex: "#452B59")
let babyBlue = Color.init(hex: "#7C7CD3")

struct MainView: View {
    let apiService = APIService()
    @State var events: [Event]
    let goToEvent: (Event) -> Void
    @State private var showSheet = false
    let user: User
    
    init(user: User, goToEvent: @escaping (Event) -> Void) {
        self.user = user
        self.goToEvent = goToEvent
        self.events = []
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                VStack(spacing: 18) {
                    ForEach(events) { event in
                        Button {
                            goToEvent(event)
                        } label: {
                            eventView(event)
                        }
                    }
                }
            }
            
            Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(babyBlue, in: .circle)
                    .padding(.vertical, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hex: "#200D2F"))
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $showSheet) {
            CreateEventView { event in
                
//                events.append(event)
                APIService.shared.createEvent(
                    name: event.name,
                    description: event.description,
                    creator: user.email) { result in
                        switch result {
                        case .success(_):
                            APIService.shared.getEvents(requesterEmail: user.email) { result in
                                switch result {
                                case .success(let success):
                                    self.events = success
                                    showSheet = false
                                case .failure(let failure):
                                    print(failure)
                                    showSheet = false
                                }
                            }
                        case .failure(let error):
                            showSheet = false
                            print(error)
                        }
                    }
                
            }
            .presentationDetents([.fraction(0.8)])
        }
        .onAppear {
            apiService.getEvents(requesterEmail: user.email) { [self] result in
                switch result {
                case .success(let events):
                    self.events = events
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @ViewBuilder
    private func eventView(_ event: Event) -> some View {
        HStack() {
            Image(.logo)
                .resizable()
                .frame(width: 32, height: 32)
                .padding(16)
                .background(Color.init(hex: "#452B5"))
            VStack(alignment: .leading, spacing: 0) {
//                Text(formatDate(event.date))
//                    .foregroundStyle(gray)
//                    .padding(.bottom, 4)
//                    .font(.subheadline)
//                    .fontWeight(.medium)
                Text(event.name)
                    .foregroundStyle(.white)
                    .padding(.bottom, 2)
                    .font(.headline)
                Text(event.description)
                    .foregroundStyle(gray)
                    .font(.caption)
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
                attendeesCapsule(event.attendees)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.95, alignment: .leading)
        .padding(.vertical, 4)
        .background(lightPurple)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func attendeesCapsule(_ attendees: [String]) -> some View {
        if attendees.count <= 3 {
            HStack {
                ForEach(attendees, id: \.self) { attendee in
                    Image(.omulet)
                        .resizable()
                        .frame(width: 10, height: 10)
                        .padding(8)
                        .background(lightPurple, in: .circle)
                }
            }
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .background(Color.init(hex: "#200D2F"), in: .capsule)
        } else {
            HStack(spacing: 4) {
                
                ForEach(attendees.prefix(3), id: \.self) { attendee in
                    Image(.omulet)
                        .resizable()
                        .frame(width: 10, height: 10)
                        .padding(8)
                        .background(lightPurple, in: .circle)
                    
                }
                
                Text("+\(attendees.count - 3)")
                    .foregroundStyle(gray)
                    .fontWeight(.bold)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 4)
                    .background(lightPurple, in: .capsule)
                
            }
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .background(Color.init(hex: "#200D2F"), in: .capsule)
        }
    }
    
    private func formatDate(_ eventDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        
        return dateFormatter.string(from: eventDate)
    }
}

