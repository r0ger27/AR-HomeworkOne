//
//  ViewController.swift
//  AR-HomeworkOne
//
//  Created by Руслан Сафин on 19/05/2019.
//  Copyright © 2019 Ruslan Safin. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
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
    
    func placeYard() {
        let scene = SCNScene(named: "art.scnassets/UnusualYard.scn")!
        let node = scene.rootNode.clone()
        let tree = loadTree()
        
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.scene.rootNode.addChildNode(tree)
        
        //      node.position = SCNVector3(-4, -1, -4)
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
        
        nodeTree.position = SCNVector3(1.5, 0.01, 2.6)
        
        let nodeTreeOne = nodeTree.clone()
        nodeTreeOne.position = SCNVector3(-2, 0.01, 1)
        
        let nodeTreeTwo = nodeTree.clone()
        nodeTreeTwo.position = SCNVector3(-3.7, 0.01, -3.5)
        
        let nodeTreeThree = nodeTree.clone()
        nodeTreeThree.position = SCNVector3(3, 0.01, 2)
        
        nodeTree.addChildNode(nodeTreeOne)
        nodeTree.addChildNode(nodeTreeTwo)
        nodeTree.addChildNode(nodeTreeThree)
        
        return nodeTree
    }
}
