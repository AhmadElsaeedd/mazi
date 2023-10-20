//
//  LoginView.swift
//  nodistance
//
//  Created by NYUAD on 19/10/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @State private var is_loading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
            VStack{
                Greeting()
                VStack{
                    TextField("ur email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .transition(.slide)
                    SecureField("and ur password", text: $viewModel.password)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .transition(.slide)
                    Button(action: {
                        Task {
                            is_loading = true
                            do {
                                try await viewModel.login()
                            } catch {
                                print("login failed: \(error)")
                            }
                            is_loading = false
                        }
                    })
                    {
                        Text("login <3")
                    }.buttonStyle(.borderedProminent)
                    .clipShape(Capsule())
                    .transition(.slide)
                    .tint(.cyan)
                    
                }
                NavigationLink(destination: HomepageView(), isActive: $viewModel.yalla_navigate) {
                    EmptyView()
                }
            }
            .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
