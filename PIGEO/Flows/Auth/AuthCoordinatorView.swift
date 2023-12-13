////
////  AuthCoordinatorView.swift
////  PIGEO
////
////  Created by Preoteasa Ioan-Silviu on 18.11.2023.
////
//
//import SwiftUI
//
//struct AuthCoordinatorView: View {
//    @StateObject private var viewModel = ViewModel()
//    let goOn: () -> Void
//    
//    var body: some View {
//        NavigationStack(path: $viewModel.navigationPath) {
//            getScreen(.register)
//        }
//    }
//    
//    @ViewBuilder
//    func getScreen(_ state: ViewModel.Screens) -> some View {
//        switch state {
//        case .register:
//            RegisterView() { user in
//                
//                goOn()
//            }
//            
//        }
//    }
//}
//
//extension AuthCoordinatorView {
//    class ViewModel: ObservableObject {
//        enum Screens {
//            case register
//        }
//        
//        @Published var navigationPath = NavigationPath()
//    }
//}
//
//#Preview {
//    AuthCoordinatorView() {}
//}
