//
//  ContentView.swift
//  nodistance
//
//  Created by NYUAD on 16/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                Greeting()
                InviteCodeView(viewModel: InviteCodeViewModel())
                .padding(.vertical, 50.0)
                StartNewFamView(viewModel: StartNewFamViewModel())
                .padding(.vertical, 50)
                LoginLinkView()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
