//
//  StartNewFamView.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import SwiftUI

struct StartNewFamView: View {
    @ObservedObject var viewModel : StartNewFamViewModel
    
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
                    .transition(.slide)
                Button(action: viewModel.next_step){
                    Text("yep")
                }.buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .transition(.slide)
            }
        case 2:
            HStack{
                SecureField("create ur password", text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .transition(.slide)
                Button(action:{
                    Task{
                        await viewModel.start_group()
                    }
                })
                {
                    Text("yep")
                }.buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .transition(.slide)
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
