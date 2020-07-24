//
//  CustomARView.swift
//  ModelPicker
//
//  Created by Fernando Fernandes on 24.07.20.
//

import RealityKit
import ARKit
import FocusEntity

class CustomARView: ARView {

    // MARK: - Properties

    var focusEntity: FocusEntity?

    // MARK: - Lifecycle

    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupFocusEntity()
        setupARView()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setupFocusEntity()
        setupARView()
    }
}

// MARK: - Private

private extension CustomARView {

    func setupFocusEntity() {
        focusEntity = FocusEntity(on: self, style: .classic(color: UIColor.red))
        focusEntity?.setAutoUpdate(to: true)
    }

    func setupARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        session.run(config)
    }
}
