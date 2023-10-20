//
//  HomepageView.swift
//  nodistance
//
//  Created by NYUAD on 20/10/2023.
//

import SwiftUI

struct HomepageView: View {
    
    var body: some View {
            Text("Home page baby")
        SignOutView(viewModel: SignOutVIewModel())
            .navigationBarBackButtonHidden(true)
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
