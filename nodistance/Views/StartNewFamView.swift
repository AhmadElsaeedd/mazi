//
//  StartNewFamView.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import SwiftUI

struct StartNewFamView: View {
    @ObservedObject var viewModel : StartNewFamViewModel
    @State private var is_loading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View{
        switch viewModel.step {
        case 0:
            VStack{
                Text("don't have an invite yet? no prob.")
                    .font(.headline)
                .fontWeight(.medium)
                Button(action: {
                    viewModel.next_step()
                })
                {
                    Text("start a fam <3")
                }.buttonStyle(.borderedProminent)
                .clipShape(Capsule())
            }
        case 1:
            HStack{
                TextField("what's ur email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .transition(.slide)
                Button(action: viewModel.next_step){
                    Text("yep")
                }.buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .transition(.slide)
            }
        case 2:
            ZStack{
                VStack{
                    HStack{
                        SecureField("create ur password", text: $viewModel.password)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .transition(.slide)
                        Button(action:{
                            is_loading = true
                            Task{
                                do{
                                    try await viewModel.start_group()
                                }
                                catch {
                                    viewModel.handle(error: error)
                                }
                                is_loading = false
                            }
                        })
                        {
                            Text("yep")
                        }.buttonStyle(.borderedProminent)
                        .clipShape(Capsule())
                        .transition(.slide)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"),
                              message: Text(viewModel.error_message ?? "An unknown error occurred"),
                              dismissButton: .default(Text("OK")) {
                                  viewModel.error_message = nil
                                    showAlert = false
                            viewModel.previous_step()
                              })
                    }
                    .onChange(of: viewModel.error_message) { newErrorMessage in
                        print("onChange triggered with message: \(String(describing: newErrorMessage))")
                        if let _ = newErrorMessage {
                            showAlert = true
                        }
                    }
                }
                if is_loading {
                        ProgressIndicatorView()
                    }
                NavigationLink(destination: NewFamInfoView(), isActive: $viewModel.yalla_navigate) {
                    EmptyView()
                }
            }
        default:
            Button(action: viewModel.first_step){
                Text("reset counter")
            }.buttonStyle(.borderedProminent)
            .clipShape(Capsule())
        }
    }
}

struct StartNewFamView_Previews: PreviewProvider {
    static var previews: some View {
        StartNewFamView(viewModel: StartNewFamViewModel())
    }
}
