//
//  Obstacle.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-12.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

enum CoinType {
    case mountain
    case cloud
    case space
    case machine
    case beyond
    
    var fileNames: [String] {
        var res = Array<String>()
        let world: String
        switch self {
        case .mountain: world = "W1"
        case .cloud: world = "W2"
        case .space: world = "W3"
        case .machine: world = "W4"
        case .beyond: world = "W5"
        }
        for i in 1...12 {
            res.append(String(format: "\(world)Frame%03d.png", i))
        }
        return res
    }
    
    var textures: [SKTexture] { return fileNames.map({ SKTexture(imageNamed: $0) }) }
}

class Coin: AnimatedSprite {
    
    static let physicsTexture = SKTexture(imageNamed: "coin-physics.png")
    let effect: SoundEffect
    
    var collected = false
    
    init(type: CoinType, position: CGPoint, with effect: SoundEffect) {
        self.effect = effect

        super.init(animateWith: type.textures)

        self.position.x = position.x + 13
        self.position.y = position.y - 21
        self.size = GameConstants.coinSize
        
        self.physicsBody = SKPhysicsBody(texture: Coin.physicsTexture, size: GameConstants.coinSize)
        self.physicsBody?.categoryBitMask    = .obstacle
        self.physicsBody?.collisionBitMask   = .player
        self.physicsBody?.contactTestBitMask = .player | .obstacle
        self.physicsBody?.affectedByGravity  = false
        self.physicsBody?.allowsRotation     = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func wasCollected() {
        self.collected = true
        if let parent = self.parent {
            effect.play(on: parent)
        }
        self.removeFromParent()
    }
}
