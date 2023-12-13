
import SwiftUI

extension View {
    func makeInfinity() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        
        return dateFormatter.string(from: self)
    }
}
