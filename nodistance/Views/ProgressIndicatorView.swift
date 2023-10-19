//
//  ProgressIndicatorView.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import SwiftUI

struct ProgressIndicatorView: View {
    var body: some View {
        ProgressView("Loading")
            .progressViewStyle(.circular)
    }
}

struct ProgressIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicatorView()
    }
}
