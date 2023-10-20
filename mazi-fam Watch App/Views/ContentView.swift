//
//  ContentView.swift
//  mazi-fam Watch App
//
//  Created by NYUAD on 20/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainButtonsView(viewModel: MainButtonsViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
