//
//  Player.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

class Player: Sprite {
    
    static let verticalImpulse: CGFloat = 1.0
    
    init(position: CGPoint) {
        super.init(imageNamed: GameConstants.playerSpriteName)
        anchorPoint = CGPoint(x:0.5, y:0.5)
        self.position = position
        
        let texture = self.texture!
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = .player
        self.physicsBody?.collisionBitMask = .player
        self.physicsBody?.contactTestBitMask = .player | .obstacle
        self.physicsBody?.friction = GameConstants.playerFiction
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clampPosition() {
        if let body = self.physicsBody {
            if self.position.x <= 0 {
                body.velocity.dx = max(body.velocity.dx, 0)
                self.position.x = 0
            }
            if self.position.x >= GameConstants.pixelWidth {
                body.velocity.dx = min(body.velocity.dx, 0)
                self.position.x = GameConstants.pixelWidth
            }
            if self.position.y <= 0 {
                body.velocity.dy = max(body.velocity.dy, 0)
                self.position.y = 0
            }
        }
    }
    
    func update(with delta: TimeInterval, and keys: Set<Key>) {

        var impulse = GameConstants.playerImpulseVertical
        if keys.contains(Key.up) && !keys.contains(Key.down){
            self.physicsBody?.applyImpulse(CGVector(dx:0.0, dy:impulse))
        }
        if keys.contains(Key.down) && !keys.contains(Key.up) {
            self.physicsBody?.applyImpulse(CGVector(dx:0.0, dy:-impulse))
        }
        impulse = GameConstants.playerImpulseHorizontal
        if keys.contains(Key.right) && !keys.contains(Key.left) {
            self.physicsBody?.applyImpulse(CGVector(dx:impulse, dy:0))
        }
        if keys.contains(Key.left) && !keys.contains(Key.right) {
            self.physicsBody?.applyImpulse(CGVector(dx:-impulse, dy:0))
        }
        clampPosition()
    }
}
