//
//  UsernameView.swift
//  nodistance
//
//  Created by NYUAD on 18/10/2023.
//

import SwiftUI

struct UsernameView: View {
    @ObservedObject var viewModel: UsernameViewModel
    @State private var is_loading: Bool = false
    
    var body: some View {
        switch viewModel.step {
        case 0:
                VStack{
                    Text("name ur family")
                        .font(.headline)
                    .fontWeight(.bold)
                    HStack{
                        //add the field that will be inputter here
                        TextField("ur fam", text: $viewModel.fam_name)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .transition(.slide)
                        Button(action: {
                            Task {
                                is_loading = true
                                do {
                                    try await viewModel.name_group()
                                } catch {
                                    print("naming group failed: \(error)")
                                }
                                is_loading = false
                            }
                        })
                        {
                            Text("next <3")
                        }.buttonStyle(.borderedProminent)
                        .clipShape(Capsule())
                        .transition(.slide)
                        .tint(.cyan)
                    }
                    if is_loading {
                            ProgressIndicatorView()
                        }
                }
        case 1:
                VStack{
                    Text("what would u like to be called?")
                        .font(.headline)
                    .fontWeight(.bold)
                    HStack{
                        //add the field that will be inputter here
                        TextField("ur username", text: $viewModel.username)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .transition(.slide)
                        Button(action:
                            {
                            Task{
                                is_loading = true
                                do{
                                    try await viewModel.add_user_name()
                                }
                                catch {
                                    print("username failed: \(error)")
                                }
                                is_loading = false
                            }
                        })
                        {
                            Text("next <3")
                        }.buttonStyle(.borderedProminent)
                        .clipShape(Capsule())
                        .transition(.slide)
                        .tint(.cyan)
                    }
                    if is_loading {
                            ProgressIndicatorView()
                        }
                }
        default:
            VStack{
                Text("what would u like to be called?")
                    .font(.headline)
                .fontWeight(.bold)
                HStack{
                    //add the field that will be inputter here
                    TextField("ur username", text: $viewModel.username)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .transition(.slide)
                    Button(action:
                        {
                        Task{
                            //add the function that will be called (probably nothing just next)
                            viewModel.next_step()
                        }
                    })
                    {
                        Text("next <3")
                    }.buttonStyle(.borderedProminent)
                    .clipShape(Capsule())
                    .transition(.slide)
                    .tint(.cyan)
                }
            }
        }
        
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView(viewModel: UsernameViewModel())
    }
}
