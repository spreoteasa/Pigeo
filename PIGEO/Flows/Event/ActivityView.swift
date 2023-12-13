//
//  ActivityView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 19.11.2023.
//

import SwiftUI

struct ActivityView: View {
    let activity: Activity
    let user: User
    @State var rating = 0
    let isAdmin: Bool
    let seeToDo: (Activity) -> Void
    
    var body: some View {
        ScrollView {
            VStack {
                Text(activity.name)
                    .fontWeight(.bold)
                    .padding(.top, 29)
                    .padding(.bottom, 16)
                Text(activity.description)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 27)
                StarRatingView(rating: $rating)
                    .padding(.bottom, 26)
                    .onChange(of: rating) {
                        APIService.shared.rateActivity(score: rating, activityId: "\(activity.id)", userEmail: user.email) { result in
                            switch result {
                            case .success(_):
                                print("x")
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }
                if isAdmin {
                    Button {
                        seeToDo(activity)
                    } label: {
                        HStack(spacing: 11) {
                            Image(.chain)
                                .resizable()
                                .frame(width: 18, height: 8)
                            Text("See To Do")
                        }
                        .fontWeight(.medium)
                        .padding([.leading, .vertical], 8)
                        .padding(.trailing, 23)
                        .background(.lightPurple, in: .capsule)
                        .padding(.bottom, 27)
                    }
                }
                ForEach(activity.attendees, id: \.self) { attendee in
                    attendeeView(attendee)
                }
            }
        }
        .foregroundStyle(.textPrimary)
        .makeInfinity()
        .background(.accent)
        .ignoresSafeArea(.keyboard)
    }
    
    
}
//#Preview {
//    ActivityView(activity: Activity.mockActivities[0]) {}
//}

@ViewBuilder
func attendeeView(_ attendee: String) -> some View {
    HStack {
        Image(.omulet)
            .resizable()
            .frame(width: 16, height: 16)
            .padding(4)
            .background(.purple, in: .circle)
            .padding(.leading, 18)
        
        Text(attendee)
        Spacer()
    }
    .frame(width: UIScreen.main.bounds.width * 0.8)
    .padding(.vertical, 9)
    .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
}
