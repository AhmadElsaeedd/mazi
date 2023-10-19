//
//  LoginLinkView.swift
//  nodistance
//
//  Created by NYUAD on 19/10/2023.
//

import SwiftUI

struct LoginLinkView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Already have an account?")
                NavigationLink(destination: LoginView(viewModel: LoginViewModel())) {
                    Text("Login")
                        .underline()
                        .foregroundColor(.blue)
                }
            }
            .font(.caption)
        }
    }
}

struct LoginLinkView_Previews: PreviewProvider {
    static var previews: some View {
        LoginLinkView()
    }
}
