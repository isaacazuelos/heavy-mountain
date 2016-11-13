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
    
    static let textureNames = [
        "player-frame-1.png",
        "player-frame-2.png",
        "player-frame-3.png",
        "player-frame-4.png",
        "player-frame-5.png",
        "player-frame-4.png",
        "player-frame-3.png",
        "player-frame-2.png",
        ]
    let textures = Player.textureNames.map({ SKTexture(imageNamed: $0) })
    
    init(position: CGPoint) {
        
        let firstTexture = textures.first!
        
        super.init(imageNamed: Player.textureNames.first!)
        
        self.scale(to: GameConstants.playerSize)
        
        anchorPoint = CGPoint(x:0.5, y:0.5)
        self.position = position
        
        self.physicsBody = SKPhysicsBody(texture: firstTexture, size: self.size)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = .player
        self.physicsBody?.collisionBitMask = .player
        self.physicsBody?.contactTestBitMask = .player | .obstacle
        self.physicsBody?.linearDamping = GameConstants.playerFiction
        
        setupAnimation()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupAnimation() {
        run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.3)))
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
    
    func clampVerticalVelocity() {
        if let dy = self.physicsBody?.velocity.dy {
            self.physicsBody?.velocity.dy = dy >= 0
                ? min(GameConstants.playerMaxSpeedUp, dy)
                : max(-GameConstants.playerMaxSpeedDown, dy)
        }
    }
    
    func clampHorizontalVelocity() {
        if let dx = self.physicsBody?.velocity.dx {
            self.physicsBody?.velocity.dx = dx >= 0
                ? min(GameConstants.playerMaxHorizontalSpeed,  dx)
                : max(-GameConstants.playerMaxHorizontalSpeed, dx)
        }

    }
    func update(with delta: TimeInterval, and keys: Set<Key>) {

        var impulse = GameConstants.playerImpulseVertical
        if keys.contains(Key.b) {
            impulse *= 2
        }
        
        if keys.contains(Key.up) && !keys.contains(Key.down){
            self.physicsBody?.applyImpulse(CGVector(dx:0.0, dy:impulse))
        }
        if keys.contains(Key.down) && !keys.contains(Key.up) {
            self.physicsBody?.applyImpulse(CGVector(dx:0.0, dy:-impulse))
        }
        
        impulse = GameConstants.playerImpulseHorizontal
        
        if keys.contains(Key.right) && !keys.contains(Key.left) {
            self.physicsBody?.applyImpulse(CGVector(dx:impulse, dy:0.0))
        }
        if keys.contains(Key.left) && !keys.contains(Key.right) {
            self.physicsBody?.applyImpulse(CGVector(dx:-impulse, dy:0.0))

        }
        if !keys.contains(Key.b) {
            clampVerticalVelocity()
        }
        clampHorizontalVelocity()
        clampPosition()
        
    }
    func collected(coin: Coin) {
        print("coin collected")
        self.physicsBody?.applyForce(CGVector(dx: 0.0, dy: GameConstants.coinBoost))
    }
}
