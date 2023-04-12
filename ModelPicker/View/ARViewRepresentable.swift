//
//  ARViewRepresentable.swift
//  ModelPicker
//
//  Created by Fernando Fernandes on 24.07.20.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewRepresentable: UIViewRepresentable {

    // MARK: - Properties

    @Binding var modelConfirmedForPlacement: Model?
    @Binding var shouldRemoveAllModels: Bool

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> ARView {
        CustomARView(frame: .zero)
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if shouldRemoveAllModels {
            uiView.scene.anchors.forEach { anchor in
                anchor.children.forEach { entity in
                    if Model.modelNames.contains(entity.name) {
                        entity.removeFromParent()
                    }
                }
            }
            DispatchQueue.main.async {
                shouldRemoveAllModels = false
            }
        } else if let model = modelConfirmedForPlacement,
                  let modelEntity = model.modelEntity {
            print("Adding model to scene: \(model.modelName)")
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(modelEntity .clone(recursive: true))
            uiView.scene.addAnchor(anchorEntity)
            DispatchQueue.main.async {
                modelConfirmedForPlacement = nil
            }
        }
    }
}
