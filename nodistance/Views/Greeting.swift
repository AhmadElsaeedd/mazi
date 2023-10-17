//
//  Greeting.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import SwiftUI

struct Greeting: View {
    var body: some View {
        VStack{
            Text("hi, in mazi")
            .font(.title)
            .fontWeight(.bold)
            Text("stay connected to your loved ones")
        }
    }
}

struct Greeting_Previews: PreviewProvider {
    static var previews: some View {
        Greeting()
    }
}
