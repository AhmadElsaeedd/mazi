//
//  MainButtonsView.swift
//  mazi-fam Watch App
//
//  Created by NYUAD on 20/10/2023.
//

import SwiftUI

struct MainButtonsView: View {
    @ObservedObject var viewModel: MainButtonsViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "person")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("hello its ahmad!")
            Button(action:
                {
                Task{
                    do{
                        //function to do anything
                        viewModel.button_click()
                    }
                    catch {
                        //viewModel.handle(error: error)
                    }
                }
            })
            {
                Text("click!")
            }.buttonStyle(.borderedProminent)
            .clipShape(Capsule())
            .transition(.slide)
            .tint(.cyan)
            
        }
        .padding()
    }
}

struct MainButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonsView(viewModel: MainButtonsViewModel())
    }
}
