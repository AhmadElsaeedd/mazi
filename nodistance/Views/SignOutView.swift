//
//  SignOutView.swift
//  nodistance
//
//  Created by NYUAD on 20/10/2023.
//

import SwiftUI

struct SignOutView: View {
    @ObservedObject var viewModel: SignOutVIewModel
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        HStack{
            Button(action:
                {
                Task{
                    do{
                        try await viewModel.sign_out()
                    }
                    catch {
                        viewModel.handle(error: error)
                    }
                }
            })
            {
                Text("sign out :(")
            }.buttonStyle(.borderedProminent)
            .clipShape(Capsule())
            .transition(.slide)
            .tint(.cyan)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.error_message ?? "An unknown error occurred"),
                  dismissButton: .default(Text("OK")) {
                      viewModel.error_message = nil
                  })
        }
        .onChange(of: viewModel.error_message) { newErrorMessage in
            if let _ = newErrorMessage {
                showAlert = true
            }
        }
        NavigationLink(destination: ContentView(), isActive: $viewModel.yalla_navigate) {
            EmptyView()
        }
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView(viewModel: SignOutVIewModel())
    }
}
