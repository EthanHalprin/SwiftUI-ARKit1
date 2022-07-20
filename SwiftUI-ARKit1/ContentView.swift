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
        
        //   V
        // ARView -> Scene -> Anchors-> Entities Heirachy
        //
        let arView = ARView(frame: .zero,
                            cameraMode: ARView.CameraMode.ar,
                            automaticallyConfigureSession: true)
        
        
        //
        // In order to create a Model Entity of type Mesh:
        // We need a mesh + material
        //
        //                                      V
        // ARView -> Scene -> Anchors-> Entities Heirachy
        //
        let mesh = MeshResource.generateBox(size: 0.05) // 0.2m
        let material = SimpleMaterial(color: .systemBlue,
                                      roughness: 0.5,
                                      isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        
        
        //
        // All model entity has to be attached to an anchor:
        //
        //                       V
        // ARView -> Scene -> Anchors-> Entities Heirachy
        //
        let anchorEntity = AnchorEntity()
        anchorEntity.addChild(modelEntity)
        
        
        //
        // Need to place anchor in our scene
        //
        //             V
        // ARView -> Scene -> Anchors-> Entities Heirachy
        //
        arView.scene.anchors.append(anchorEntity)
        
        
        return arView

    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
/*
 
 Materials (iOS 13-14-15)
 
 /// A basic, unlit material. (Similar to `SimpleMaterial` except that
 ///  this material is not affected by lights in an AR scene.)
 @available(macOS 10.15, iOS 13.0, *)
 public struct UnlitMaterial : Material {

 
 @available(macOS 11.0, iOS 14.0, *)
 public struct VideoMaterial : Material {

 
 @available(macOS 11.0, iOS 15.0, *)
 public struct CustomMaterial : Material {

 
 /// A reference to a function, marked with the [[visible]] attribute, which is contained
 /// within a specified Metal library.
 @available(macOS 11.0, iOS 15.0, *)
 public struct SurfaceShader : MaterialFunction {

 
 /// Creates an invisible material that will hide all objects that are rendered behind the mesh.
 @available(macOS 10.15, iOS 13.0, *)
 public struct OcclusionMaterial : Material {


 @available(macOS 11.0, iOS 15.0, *)
 public struct PhysicallyBasedMaterial : Material {
 
 */

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
