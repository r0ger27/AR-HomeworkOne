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

class ViewController: UIViewController, ARSCNViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - Vars
    let configuration = ARWorldTrackingConfiguration()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        
        placeYard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    func placeYard() {
        let scene = SCNScene(named: "art.scnassets/UnusualYard.scn")!
        let node = scene.rootNode.clone()
        let tree = loadTree()
        
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.scene.rootNode.addChildNode(tree)
        
        node.runAction(.repeatForever(.rotateBy(x: 0, y: 0, z: 0, duration: 3)))
    }
    
    func loadTree() -> SCNNode {
        let nodeTree = SCNNode()
        
        let nodeCylinder = SCNNode(geometry: SCNCylinder(radius: 0.15, height: 2.1))
        nodeCylinder.position.y = 1
        
        let nodeSphere = SCNNode(geometry: SCNSphere(radius: 1))
        nodeSphere.position.y = 2.4
        
        nodeCylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        nodeSphere.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        
        nodeTree.addChildNode(nodeCylinder)
        nodeTree.addChildNode(nodeSphere)
        
        nodeTree.position = SCNVector3(2.9, -2.0, -3.6)
        nodeTree.scale = SCNVector3(0.2, 0.2, 0.2)
        
        let nodeTreeOne = nodeTree.clone()
        nodeTreeOne.position = SCNVector3(-9.0, -2.0, 2.0)
        nodeTreeOne.scale = SCNVector3(1, 1, 1)
        
        let nodeTreeTwo = nodeTree.clone()
        nodeTreeTwo.position = SCNVector3(-23.0, -2.0, 3.2)
        nodeTreeTwo.scale = SCNVector3(1, 1, 1)
        
        let nodeTreeThree = nodeTree.clone()
        nodeTreeThree.position = SCNVector3(-28.1, -2.0, -6.6)
        nodeTreeThree.scale = SCNVector3(1, 1, 1)
        
        let nodeTreeFour = nodeTree.clone()
        nodeTreeFour.position = SCNVector3(-6.0, -2.0, 8.0)
        nodeTreeFour.scale = SCNVector3(1, 1, 1)
        
        nodeTree.addChildNode(nodeTreeOne)
        nodeTree.addChildNode(nodeTreeTwo)
        nodeTree.addChildNode(nodeTreeThree)
        nodeTree.addChildNode(nodeTreeFour)
        
        return nodeTree
    }
}
