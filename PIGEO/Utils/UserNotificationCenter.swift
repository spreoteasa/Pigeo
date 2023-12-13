//
//  UserNotificationCenter.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import SwiftUI
import SwiftMessages

class UserNotificationCenter {
    static let shared = UserNotificationCenter()
    
    func notifyUsers(_ task: ActivityTodo) {
        let view = MessageView.viewFromNib(layout: .cardView)

        // Theme message elements with the warning style.
        view.configureTheme(.success)
        view.button?.isHidden = true
        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["🔥"].randomElement()!
        view.configureContent(title: "\(task.title)", body: "Status changed to: \(task.status.rawValue)", iconText: iconText)

        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10

        // Show the message.
        SwiftMessages.show(view: view)
    }
    
}
