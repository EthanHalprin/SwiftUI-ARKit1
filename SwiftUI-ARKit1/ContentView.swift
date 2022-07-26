//
//  ContentView.swift
//  SwiftUI-ARKit1
//
//  Created by Ethan on 20/07/2022.
//

import SwiftUI


struct ContentView : View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
