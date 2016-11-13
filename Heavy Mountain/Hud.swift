//
//  Hud.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-12.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

class Hud: SKNode {

    var highestPoint: Int = 0
    let highestPointLabel: SKLabelNode
    
    override init() {
        highestPointLabel = SKLabelNode(fontNamed: "Futura")
        
        highestPointLabel.fontSize = 10
        highestPointLabel.verticalAlignmentMode = .top
        highestPointLabel.horizontalAlignmentMode = .left
        
        let y = Int(floor(GameConstants.pixelHeight))
        
        highestPointLabel.position = CGPoint(x: 0, y: y)
        highestPointLabel.zPosition = 100000000
        super.init()
        addChild(highestPointLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with world: World) {
        if let player = world.player {
            highestPoint = max(highestPoint, Int(player.position.y))
        }
        highestPointLabel.text = "highest: \(highestPoint)"
    }
}
