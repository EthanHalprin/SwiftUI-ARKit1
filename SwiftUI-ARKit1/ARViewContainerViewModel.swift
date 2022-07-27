//
//  ARViewContainerViewModel.swift
//  SwiftUI-ARKit1
//
//  Created by Ethan on 27/07/2022.
//

import Foundation
import SwiftUI
import ARKit
import RealityKit


class ARViewContainerViewModel {
    
    func createFloorEntity(_ arView: ARView) {
    
        /// Create anchor entity for attaching content
        let floorAnchor = AnchorEntity(plane: .horizontal, classification: AnchoringComponent.Target.Classification.floor)
        arView.scene.addAnchor(floorAnchor)
        
        /// Generate a mesh box
        let box = MeshResource.generateBox(size: 0.2, cornerRadius: 0.0075)
        /// Create a simple metallic gray material
        let metal = SimpleMaterial(color: .yellow, roughness: 0.1, isMetallic: true)
        
        /// Create a model entity from mesh and material
        let modelEntity = ModelEntity(mesh: box, materials: [metal])
        
        /// Attach this model to our floor anchor
        floorAnchor.addChild(modelEntity)
        
        /// Finally - attach the anchor to our scene
        arView.scene.addAnchor(floorAnchor)
    }
    
    func createTableEntity(_ arView: ARView) {
        /// Create anchor entity for attaching content
        let tableAnchor = AnchorEntity(plane: .horizontal, classification: AnchoringComponent.Target.Classification.table)
        arView.scene.addAnchor(tableAnchor)
        
        /// Generate a mesh box
        let mesh2 = MeshResource.generateBox(size: 0.1, cornerRadius: 0.0075)

        /// Create a simple material
        let blueMetal = SimpleMaterial(color: .blue, roughness: 0.7, isMetallic: false)
        
        /// Create a model entity from mesh and material
        let modelEntity2 = ModelEntity(mesh: mesh2, materials: [blueMetal])
        
        /// Attach this model to our table anchor
        tableAnchor.addChild(modelEntity2)
        
        /// Finally - attach the anchor to our scene
        arView.scene.addAnchor(tableAnchor)
    }
    
    func createVideoEntity(_ arView: ARView) {
        
        //
        // Apple
        // https://developer.apple.com/documentation/realitykit/videomaterial
        //
        
        // Create a URL that points to the movie file.
        guard let url = Bundle.main.url(forResource: "file_example_MP4_480_1_5MG", withExtension: "mp4") else {
            fatalError("ERROR: Could not find video file on createVideoEntity")
        }

        // Create an AVPlayer instance to control playback of that movie.
        let player = AVPlayer(url: url)
                
        //
        // In order to create a Model Entity of type Mesh:
        // We need a mesh + material
        //
        let cube = MeshResource.generateBox(size: 0.05, cornerRadius: 10.0)

        // Instantiate and configure the video material.
        let material = VideoMaterial(avPlayer: player)

        // Configure audio playback mode.
        material.controller.audioInputMode = .spatial

        // Create a new model entity using the video material.
        let modelEntity = ModelEntity(mesh: cube, materials: [material])
        
        // Start playing the video.
        player.play()
        
        let anchorEntity = AnchorEntity()
        anchorEntity.addChild(modelEntity)
        anchorEntity.transform.matrix.columns.3.x += 0.15
        arView.scene.addAnchor(anchorEntity)
    }

}
