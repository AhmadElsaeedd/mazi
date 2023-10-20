//
//  NewFamInfoView.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import SwiftUI

struct NewFamInfoView: View {
    var body: some View {
            VStack{
                Greeting()
                UsernameView(viewModel: UsernameViewModel())
            }
            .padding()
    }
}

struct NewFamInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NewFamInfoView()
    }
}
