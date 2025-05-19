//
//  ViewController.swift
//  GraphExample
//
//  Created by Tolga Taner on 16.05.2025.
//

import UIKit
import graph

final class ViewController: UIViewController {
    
    var graphLoader: GraphLoader = GraphLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let _ = try graphLoader.load()
            if let nearestWC = graphLoader.findNearestNode(from: "d143c6b3-d26e-4e62-8f97-c395f229e04e", targetType: "point") {
                print("nearest: \(nearestWC.id)")
            } else {
                print("no nodes.")
            }
        }
        catch (let error) {
            print(error)
        }
    }


}

