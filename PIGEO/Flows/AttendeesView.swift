//
//  AttendeesView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 19.11.2023.
//

import SwiftUI

struct AttendeesView: View {
    let attendees: [String]
    var body: some View {
        ScrollView {
            ForEach(attendees, id: \.self) {attendee in
                attendeeView(attendee)
            }
        }
        .scrollIndicators(.never)
        .makeInfinity()
        .background(.accent)
        .ignoresSafeArea(.keyboard)
    }
}

//#Preview {
//    AttendeesView(attendees: Activity.mockActivities[0].attendees)
//}
