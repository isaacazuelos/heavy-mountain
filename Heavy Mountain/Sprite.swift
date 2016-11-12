//
//  BackgroundSprite.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

class Sprite: SKSpriteNode {
    init(imageNamed name: String) {
        let texture = SKTexture(imageNamed: name)
        texture.filteringMode = .linear
        
        super.init(texture: texture, color: .black, size: texture.size())
        self.anchorPoint = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Player: Sprite {
    
    init(position: CGPoint) {
        super.init(imageNamed: GameConstants.playerSpriteName)
        anchorPoint = CGPoint(x:0.5, y:0.5)
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with delta: TimeInterval, and keys: Set<Key>) {
        if keys.contains(Key.up) {
            self.position.y += 1
        }
        if keys.contains(Key.down) {
            self.position.y -= 1
        }
    }
}

class BackgroundSprite: Sprite {
    
}
