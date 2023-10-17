//
//  InviteCodeView.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import SwiftUI

struct InviteCodeView: View {
    @ObservedObject var viewModel: InviteCodeViewModel
    
    var body: some View{
        switch viewModel.step {
        case 0:
            HStack{
                TextField("ur invite code", text: $viewModel.inv_code)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .transition(.slide)
                Button(action: {
                    Task{
                        await viewModel.check_inv_code()
                    }
                })
                {
                    Text("join a fam <3")
                }.buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .transition(.slide)
                .tint(.pink)
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
            HStack{
                SecureField("create ur password", text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .transition(.slide)
                Button(action: viewModel.create_user){
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

struct InviteCodeView_Previews: PreviewProvider {
    static var previews: some View {
        InviteCodeView(viewModel: InviteCodeViewModel())
    }
}
