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
                
        //
        // Building AR View is done according to this relations scheme:
        // https://developer.apple.com/documentation/realitykit/arview
        //
        let arView = ARView(frame: .zero,
                            cameraMode: ARView.CameraMode.ar,
                            automaticallyConfigureSession: true)

        //
        // Add Video Entity
        //
        if let anchorVideoEntity = createVideoEntity() {
            anchorVideoEntity.transform.matrix.columns.3.x += 0.1
            arView.scene.anchors.append(anchorVideoEntity)
            print("\nCreated & added video entity OK\n")
        }

        //
        // Add Simple Entity
        //
        let anchorSimpleEntity = createSimpleEntity()
        arView.scene.anchors.append(anchorSimpleEntity)
        print("\nCreated & added simple entity OK\n")

        return arView

    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
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

        //
        // In order to create a Model Entity of type Mesh:
        // We need a mesh + material
        //
        let cube = MeshResource.generateBox(size: 0.05)

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
