//
//  ContentView.swift
//  SwiftUI-ARKit1
//
//  Created by Ethan on 20/07/2022.
//

import SwiftUI
import ARKit
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
                
        /// Building AR View is done according to this relations scheme:
        /// https://developer.apple.com/documentation/realitykit/arview
        let arView = ARView(frame: .zero, cameraMode: ARView.CameraMode.ar, automaticallyConfigureSession: true)
    
        /// Create anchor entity for attaching content
        let floorAnchor = AnchorEntity(plane: .horizontal, classification: AnchoringComponent.Target.Classification.floor)
        arView.scene.addAnchor(floorAnchor)
        
        /// Generate a mesh box
        let box = MeshResource.generateBox(size: 0.2, cornerRadius: 0.0075)
        /// Create a simple metallic gray material
        let metal = SimpleMaterial(color: .yellow, roughness: 0.1, isMetallic: true)
        
        /// Create a model entity from mesh and material
        let modelEntity = ModelEntity(mesh: box, materials: [metal])
        
        /// Attach this model ot our floor anchor
        floorAnchor.addChild(modelEntity)
        
        /// Finally - attach the anchor to our scene
        arView.scene.addAnchor(floorAnchor)
        
        //----------------------------------------------------------------------------
        
        /// Create anchor entity for attaching content
        let tableAnchor = AnchorEntity(plane: .horizontal, classification: AnchoringComponent.Target.Classification.table)
        arView.scene.addAnchor(tableAnchor)
        
        /// Generate a mesh box
        let mesh2 = MeshResource.generateBox(size: 0.1, cornerRadius: 0.0075)

        /// Create a simple metallic gray material
        let blueMetal = SimpleMaterial(color: .blue, roughness: 0.7, isMetallic: true)
        
        /// Create a model entity from mesh and material
        let modelEntity2 = ModelEntity(mesh: mesh2, materials: [blueMetal])
        
        /// Attach this model ot our floor anchor
        tableAnchor.addChild(modelEntity2)
        
        /// Finally - attach the anchor to our scene
        arView.scene.addAnchor(tableAnchor)


        //----------------------------------------------------------------------------

        
//        /// Add Simple Entity
//        let anchorSimpleEntity = createSimpleEntity()
//        arView.scene.addAnchor(anchorSimpleEntity)
//        print("\nCreated & added simple entity OK\n")

        /// Add Video Entity
        if let anchorVideoEntity = createVideoEntity() {
            anchorVideoEntity.transform.matrix.columns.3.x += 0.15
            arView.scene.addAnchor(anchorVideoEntity)
        }
        
        return arView

                 
    }
    
    /// Add spotlight

    func updateUIView(_ uiView: ARView, context: Context) {
    }
    
}

extension ARViewContainer {
    
    // Approx 440MB
    func createSimpleEntity() -> AnchorEntity {
       
        //
        // Reality School
        // https://www.youtube.com/watch?v=itGRaAryUxA
        //
        
        let mesh = MeshResource.generateBox(size: 0.05)
        let material = SimpleMaterial(color: .systemBlue,
                                      roughness: 0.5,
                                      isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        let anchorEntity = AnchorEntity()
         
        anchorEntity.addChild(modelEntity)
        
        return anchorEntity
    }
}

extension ARViewContainer {
    
    func createVideoEntity() -> AnchorEntity? {
        
        //
        // Apple
        // https://developer.apple.com/documentation/realitykit/videomaterial
        //
        
        // Create a URL that points to the movie file.
        guard let url = Bundle.main.url(forResource: "file_example_MP4_480_1_5MG", withExtension: "mp4") else {
            return nil
        }

        // Create an AVPlayer instance to control playback of that movie.
        let player = AVPlayer(url: url)
        
//AVPlayerLooper -> https://stackoverflow.com/questions/5361145/looping-a-video-with-avfoundation-avplayer
        
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
        
        return anchorEntity
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
