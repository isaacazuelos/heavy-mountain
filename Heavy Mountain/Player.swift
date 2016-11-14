//
//  Player.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

class Player: AnimatedSprite {
    
    static let boundries: [CGFloat] = [265, 618, 907, 1195, 1563]
    static let verticalImpulse: CGFloat = 1.0
    static let textureNames = (1...9).map { String(format: "playerFrame%03d.png", $0) }
    var hasGoneUp = false
    var coinCount: Int = 0
    init(position: CGPoint) {

        let textures = Player.textureNames.map({ SKTexture(imageNamed: $0) })
        super.init(animateWith: textures)
        
        self.scaleWidth(to: GameConstants.playerSize.width)
        
        anchorPoint = CGPoint(x:0.5, y:0.5)
        self.position = position
        
        self.physicsBody = SKPhysicsBody(texture: textures.first!, size: self.size)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false // set to true when they try to lift off.
        self.physicsBody?.categoryBitMask = .player
        self.physicsBody?.collisionBitMask = .player
        self.physicsBody?.contactTestBitMask = .player | .obstacle
        self.physicsBody?.linearDamping = GameConstants.playerFiction
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func clampPositionInGame() {
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
    func setRotation() {
        
        if !hasGoneUp {
            self.zRotation = 0
            return
        }
        
        guard let x = self.physicsBody?.velocity.dx else { return }
        guard let y = self.physicsBody?.velocity.dy else { return }
        self.zRotation = atan2(y, x) - (CGFloat.pi / 2)
    }
    func update(with delta: TimeInterval, and keys: Set<Key>) {
 
        if keys.contains(Key.r) { coinCount += 1 }
        
        if !hasGoneUp && keys.contains(Key.up) {
            hasGoneUp = true
            self.physicsBody?.affectedByGravity = true
        }
        
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
        if !keys.contains(Key.b) { clampVerticalVelocity() }
        clampHorizontalVelocity()
        clampPositionInGame()
        if !keys.contains(Key.b) { applyCoinRestrictions() }
        
        setRotation()
    }
    func collected(coin: Coin) {
        if !coin.collected { self.coinCount += 1 }
        self.physicsBody?.applyForce(CGVector(dx: 0.0, dy: GameConstants.coinBoost))
    }
    func applyCoinRestrictions() {
        if coinCount >= GameConstants.coins.count {
            return
        }
        let index = Int(floor(Float(coinCount) / 4.0))
        
        if index < Player.boundries.count {
            let maxHeight = Player.boundries[index]
            position.y = min(position.y, maxHeight)
        }
    }
}
