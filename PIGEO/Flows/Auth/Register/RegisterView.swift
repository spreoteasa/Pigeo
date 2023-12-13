//
//  RegisterView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = ViewModel()
    let goOn: (User) -> Void
    
    var content: some View {
        VStack(spacing: 0) {
            PGTextField(image: Image(.user), name: "Email", isSecure: false, field: $viewModel.user.email)
                .padding(.bottom, 16)
            PGTextField(image: Image(.lock), name: "Password", isSecure: true, field: $viewModel.user.password)
                .foregroundStyle(Color.init(hex: "#B9B9C7"))
                .padding(.bottom, 16)
            Button {
                APIService().login(user: viewModel.user, completionHandler: {
                    goOn(viewModel.user)
                })
            } label: {
                Text("Sign In")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 67)
                    .padding(.vertical, 8)
                    .background(Color.init(hex: "#7C7CD3"), in: RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding(.horizontal, 16)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            content
            Spacer()
            Color.gray.frame(height: 1)
            HStack {
                Image(.logo)
                    .padding(.vertical, 8)
                Spacer()
                VStack {
                    HStack {
                        Link(destination: URL(string: "https://instagram.com/pigeo_development?igshid=MTk0NTkyODZkYg==")!) {
                            Image(.instagram)
                        }
                        
                        Image(.facebook)
                        Image(.web)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxHeight: .infinity )
        .ignoresSafeArea()
        .background(Color.init(hex: "#200D2F"))
        .toolbarTitleDisplayMode(.inline)
        .navigationTitle("Login")
    }
}

extension RegisterView {
    class ViewModel: ObservableObject {
        @Published var user = User(email: "denisa.malan@stud.ubbcluj.ro", password: "")
    }
}

