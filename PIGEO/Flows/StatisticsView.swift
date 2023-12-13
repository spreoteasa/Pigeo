//
//  StatisticsView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 19.11.2023.
//

import SwiftUI
import Foundation
import Alamofire

//{
//    "attendees": 3,
//    "score": "3.5",
//    "numberOfReviews": 2,
//    "activitiesStats": [
//        {
//            "attendees": "67",
//            "score": "2.0",
//            "numberOfReviews": 1
//        }
//    ]
//}
struct ActivitiesStats: Codable {
    let attendees: String
    let score: String
    let numberOfReviews: Int
}
struct Statistics: Codable {
    let attendees: Int
    let score: String
    let numberOfReviews: Int
    let activitiesStats: [ActivitiesStats]
}

struct StatisticsView: View {
    let event: Event
    @State var statistics: Statistics? = nil
    var body: some View {
        VStack {
            Text(event.name)
                .foregroundStyle(.textPrimary)
                .fontWeight(.bold)
            HStack {
                Text("\(event.attendees.count) attendees")
                    .foregroundStyle(.textPrimary)
                    .padding(8)
                    .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
                
                if let stat = statistics {
                    VStack {
                        Text("\(stat.score)/5")
                        Text("\(stat.numberOfReviews) reviews")
                    }
                        .foregroundStyle(.textPrimary)
                        .padding(8)
                        .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
                }
            }
            .padding(.bottom, 65)
            ScrollView {
                VStack {
                    ForEach(Array(event.activities.enumerated()), id:\.element) { index, activity in
                        HStack {
                            if let statistic = statistics?.activitiesStats[index]{
                            Spacer()
                            Text(activity.name)
                                .foregroundStyle(.textPrimary)
                                .fontWeight(.bold)
                            Spacer()
                            
                                Pie(slices: [(Double(statistic.attendees)!, .babyBlue), ((100 - Double(statistic.attendees)!), .skin)])
                                .frame(width: 50, height: 50)
                                VStack {
                                    Text("\(statistic.score)/5")
                                        .foregroundStyle(.textPrimary)
                                        .fontWeight(.bold)
                                    Text("\(statistic.numberOfReviews) reviews")
                                        .foregroundStyle(.textPrimary)
                                        .fontWeight(.bold)
                                }
                            Spacer()
                                
                            }
                        }
                    }
                }
            }
        }
        .makeInfinity()
        .ignoresSafeArea(.keyboard)
        .background(.accent)
        .onAppear {
            APIService.shared.getEventStatistics(eventId: "\(event.id)") { result in
                switch result {
                case .success(let statistics):
                    self.statistics = statistics
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

//#Preview {
//    StatisticsView(event: Event.mockEvents[0])
//}

struct Pie: View {
    @State var slices: [(Double, Color)]
    var body: some View {
        Canvas { context, size in
            // Add these lines to display as Donut
            //Start Donut
            let donut = Path { p in
                p.addEllipse(in: CGRect(origin: .zero, size: size))
                p.addEllipse(in: CGRect(x: size.width * 0.25, y: size.height * 0.25, width: size.width * 0.5, height: size.height * 0.5))
            }
            context.clip(to: donut, style: .init(eoFill: true))
            //End Donut
            let total = slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.48
            let gapSize = Angle(degrees: 0) // size of the gap between slices in degrees
            
            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle + gapSize / 2, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
