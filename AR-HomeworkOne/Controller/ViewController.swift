//
//  ViewController.swift
//  AR-HomeworkOne
//
//  Created by Ruslan Safin on 19/05/2019.
//  Copyright © 2019 Ruslan Safin. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - Vars
    let configuration = ARWorldTrackingConfiguration()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        sceneView.debugOptions = [.showFeaturePoints]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configuration.planeDetection = [.horizontal]
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}

// MARK: - Extensions
extension ViewController {
    
    // MARK: - Methods
    func loadTree() -> SCNNode {
        let nodeTree = SCNNode()
        
        let nodeCylinder = SCNNode(geometry: SCNCylinder(radius: 0.15, height: 1.5))
        nodeCylinder.position.y = 1
        
        let nodeSphere = SCNNode(geometry: SCNSphere(radius: 1))
        nodeSphere.position.y = 2.4
        
        nodeCylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        nodeSphere.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/Crown.png")
        
        nodeTree.addChildNode(nodeCylinder)
        nodeTree.addChildNode(nodeSphere)
        
        return nodeTree
    }
}

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        DispatchQueue.global().async {
            let yard = self.createYard(with: planeAnchor)
            yard.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            node.addChildNode(yard)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        guard let yardNode = node.childNodes.first else { return }
        
        yardNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
    }
    
    func createYard(with planeAnchor: ARPlaneAnchor) -> SCNNode {
        let scene = SCNScene(named: "art.scnassets/UnusualYard.scn")!
        let node = scene.rootNode.clone()
        
        let tree = loadTree()
        tree.position = SCNVector3(0.01, -0.02, 0.02)
        tree.scale = SCNVector3(0.02, 0.02, 0.02)
        
        let nodeTreeOne = tree.clone()
        nodeTreeOne.position = SCNVector3(-0.15, -0.02, 0.1)
        nodeTreeOne.scale = SCNVector3(0.02, 0.02, 0.02)
        
        let nodeTreeTwo = tree.clone()
        nodeTreeTwo.position = SCNVector3(0.15, -0.02, 0.15)
        nodeTreeTwo.scale = SCNVector3(0.02, 0.02, 0.02)
        
        node.addChildNode(tree)
        node.addChildNode(nodeTreeOne)
        node.addChildNode(nodeTreeTwo)
        
        return node
    }
}
