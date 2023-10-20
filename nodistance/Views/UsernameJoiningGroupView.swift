//
//  UsernameJoiningGroupView.swift
//  nodistance
//
//  Created by NYUAD on 19/10/2023.
//

import SwiftUI

struct UsernameJoiningGroupView: View {
    var body: some View {
            VStack{
                Greeting()
                Username2View(viewModel: Username2ViewModel())
            }
            .padding() 
    }
}

struct UsernameJoiningGroupView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameJoiningGroupView()
    }
}
