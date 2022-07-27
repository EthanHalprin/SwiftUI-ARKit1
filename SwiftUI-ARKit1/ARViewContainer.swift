//
//  ARViewContainer.swift
//  SwiftUI-ARKit1
//
//  Created by Ethan on 27/07/2022.
//

import Foundation
import SwiftUI
import ARKit
import RealityKit


struct ARViewContainer: UIViewRepresentable {
    
    let viewModel = ARViewContainerViewModel()
    
    ///
    /// Building AR View is done according to this relations scheme + WWDC Additions
    ///
    /// https://developer.apple.com/documentation/realitykit/arview
    func makeUIView(context: Context) -> ARView {
                
        let arView = ARView(frame: .zero, cameraMode: ARView.CameraMode.ar, automaticallyConfigureSession: true)

        viewModel.createFloorEntity(arView)
        viewModel.createTableEntity(arView)
        viewModel.createVideoEntity(arView)
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
    }
   
}
