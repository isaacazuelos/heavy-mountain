//
//  BackgroundSprite.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

class BackgroundSprite: SKSpriteNode {
    init(imageNamed name: String) {
        let texture = SKTexture(imageNamed: name)
        texture.filteringMode = .nearest
        
        super.init(texture: texture, color: .black, size: texture.size())
        self.anchorPoint = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
