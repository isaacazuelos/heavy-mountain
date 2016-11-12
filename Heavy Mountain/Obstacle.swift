//
//  Obstacle.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-12.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle: Sprite {
    override init(imageNamed name: String) {
        super.init(imageNamed: name)
        if let texture = self.texture {
            self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
            self.physicsBody?.categoryBitMask = .obstacle
            self.physicsBody?.collisionBitMask = .player 
            self.physicsBody?.contactTestBitMask = .player | .obstacle
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.allowsRotation = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
