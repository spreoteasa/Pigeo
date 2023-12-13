//
//  EventView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import SwiftUI

struct EventView: View {
    @State var showSheet = false
    let event: Event
    let isAdmin: Bool
    let user: User
    let goToActivity: (Activity) -> Void
    let seeAttendees: ([String]) -> Void
    let seeStatistics: (Event) -> Void
    let seeTodo: (Event) -> Void
    
    @State var rating = 0
    
    var body: some View {
        VStack {
            header
            ScrollView {
                VStack(spacing: 0) {
                    Text(event.description)
                        .fontWeight(.medium)
                        .foregroundStyle(.textPrimary)
                        .padding(.bottom, 30)
                    VStack(spacing: 8) {
                        if isAdmin {
                            button(text: "See To Do", icon: Image(.chain), completion: {
                              seeTodo(event)
                            })
                        }
                        HStack(spacing: 25) {
                            button(text: "See Statistics", icon: Image(.chain), completion: {
                                seeStatistics(event)
                            })
                            
                            button(text: "See Attendees", icon: Image(.chain), completion: {
                                seeAttendees(event.attendees)
                            })
                        }
                    }
                    .padding(.bottom, 30)
                    StarRatingView(rating: $rating)
                        .padding(.bottom, 26)
                        .onChange(of: rating) {
                            APIService.shared.rateEvent(score: rating, eventId: "\(event.id)", userEmail: user.email) { result in
                                switch result {
                                case .success(_):
                                    print("x")
                                case .failure(let failure):
                                    print(failure)
                                }
                            }
                        }
                    ForEach(event.activities) { activity in
                        VStack(spacing: 0) {
                            Button {
                                goToActivity(activity)
                            } label: {
                                self.activity(activity)
                            }
                            .padding(.bottom, 9)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
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
        }
        .makeInfinity()
        .background(.accent)
        .sheet(isPresented: $showSheet, content: {
            AddActivity(eventId: "\(event.id)")
        })
        .ignoresSafeArea(.keyboard)
    }
    
    @ViewBuilder
    private func activity(_ activity: Activity) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
//                Text(activity.date.formatDate())
//                    .fontWeight(.medium)
//                    .foregroundStyle(.textSecondary)
                Text(activity.name)
                    .fontWeight(.medium)
                    .foregroundStyle(.textPrimary)
                Text(activity.description)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.medium)
                    .foregroundStyle(.textSecondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .foregroundStyle(.textPrimary)
                .frame(width: 22, height: 29)
                .padding(.trailing, 24)
        }
        .padding(.leading, 15)
        .padding(.vertical, 17)
        .frame(maxWidth: .infinity)
        .background(.altMov)
    }
    
    var header: some View {
        ZStack {
            Image(.coronini)
                .resizable()
            VStack {
                Spacer()
                HStack {
                    Text(event.name)
                        .foregroundStyle(.textPrimary)
                        .fontWeight(.bold)
                        .frame(alignment: .bottomLeading)
                        .padding(.bottom, 6)
                        .padding(.leading, 9)
                    Spacer()
                }
            }
        }
        .frame(height: 184)
    }
}


@ViewBuilder
func button(
    text: String,
    icon: Image,
    completion: @escaping () -> Void
) -> some View {
    Button {
        completion()
    } label: {
        Text(text)
            .foregroundStyle(.textPrimary)
            .fontWeight(.medium)
            .padding(.vertical, 8)
            .frame(width: 140)
            .background(.lightPurple, in: .capsule)
    }
}


//{
//    "name": "First Activity",
//    "description": "Lorem Ipsum mama ta gagica mea but in activity",
//    "requesterEmail": "denisa.malan@stud.ubbcluj.ro",
//    "eventId": "4"
//}
struct AddActivity: View {
    @State var name = ""
    @State var description = ""
    @State var requesterEmail = ""
    let eventId: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            TextField(text: $name, label: {
                Text("Activity name")
                    .foregroundStyle(.textPrimary)
            })
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
            TextField(text: $description, axis: .vertical) {
                Text("Activity Description")
                    .foregroundStyle(.textPrimary)
            }
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
            TextField(text: $requesterEmail, label: {
                Text("Requester Email")
                    .foregroundStyle(.textPrimary)
                    
            })
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
            
            Button {
                APIService.shared.createActivity(name: name, description: description, creator: requesterEmail, eventId: eventId) { result in
                    switch result {
                    case .success(_):
                        print("success")
                        dismiss()
                    case .failure(let failure):
                        print(failure)
                        dismiss()
                    }
                }
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
            Color(.accent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle("Create")
            
        }
    }
}
