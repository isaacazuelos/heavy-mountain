//
//  Obstacle.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-12.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

class Coin: Sprite {
    
    let effect: SoundEffect
    
    init(imageNamed name: String, position: CGPoint, with effect: SoundEffect) {
        self.effect = effect

        super.init(imageNamed: name)

        self.position = position
        
        if let texture = self.texture {
            self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
            self.physicsBody?.categoryBitMask    = .obstacle
            self.physicsBody?.collisionBitMask   = .player
            self.physicsBody?.contactTestBitMask = .player | .obstacle
            self.physicsBody?.affectedByGravity  = false
            self.physicsBody?.allowsRotation     = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func wasCollected() {
        if let parent = self.parent {
            effect.play(on: parent)
        }
        self.removeFromParent()
    }
}
