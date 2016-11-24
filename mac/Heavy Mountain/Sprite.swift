//
//  BackgroundSprite.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

extension UInt32 {
    static let noclip: UInt32 = 0
    static let player: UInt32 = 1
    static let obstacle: UInt32 = 2
}

class Sprite: SKSpriteNode {
    init() {
        super.init(texture: nil, color: .black, size: .zero)
    }
    
    init(imageNamed name: String) {
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .black, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func scaleWidth(to width: CGFloat) {
        let ratio = (width / self.size.width)
        self.setScale(ratio)
    }
}

class AnimatedSprite: Sprite {
    var textures: [SKTexture]
    init(animateWith textures: [SKTexture]) {
        self.textures = textures
        super.init(imageNamed: "player")
        self.setupAnimation()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupAnimation() {
        run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.2)))
    }
}

class BackgroundSprite: Sprite {
    override init(imageNamed name: String) {
        super.init(imageNamed: name)
        self.anchorPoint = .zero
        self.scaleWidth(to: GameConstants.pixelWidth)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
