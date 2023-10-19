//
//  Username2View.swift
//  nodistance
//
//  Created by NYUAD on 19/10/2023.
//

import SwiftUI

struct Username2View: View {
    @ObservedObject var viewModel: Username2ViewModel
    @State private var is_loading: Bool = false
    
    var body: some View {
        switch viewModel.step{
        case 0:
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
        }
    }
}

struct Username2View_Previews: PreviewProvider {
    static var previews: some View {
        Username2View(viewModel: Username2ViewModel())
    }
}
