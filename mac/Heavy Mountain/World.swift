//
//  World.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

extension CGFloat {
    static let playerPlane: CGFloat = 0
    static let behindPlayer: CGFloat = -1
    static let background: CGFloat = -10
    static let foreground: CGFloat = 10
}

class World: SKNode {
    
    var player: Player? {
        get { return self.childNode(withName: "player") as? Player }
        set {
            self.removeChildren(in: children.filter { $0.name == "player" })
            newValue.map {
                $0.name = "player"
                $0.zPosition = .playerPlane
                self.addChild($0)
            }
        }
    }
    
    override init() {
        super.init()
        self.name = "world"
        
        // background
        let bg1 = BackgroundSprite(imageNamed: "background")
        bg1.zPosition = .background
        self.addChild(bg1)
        
        // mountain
        let mountain = BackgroundSprite(imageNamed: GameConstants.mountainImageName)
        mountain.zPosition = .behindPlayer
        mountain.name = "mountain"
        self.addChild(mountain)

        // boundries
        let boundries = BackgroundSprite(imageNamed: "boundries")
        boundries.zPosition = .foreground
        self.addChild(boundries)
        
        // beyond
        let beyond = BackgroundSprite(imageNamed: "beyond")
        beyond.zPosition = .foreground
        beyond.position.y = 1000
        self.addChild(beyond)
        
        // player
        player = Player(position: CGPoint(x: GameConstants.pixelWidth / 2, y: GameConstants.pixelHeight / 4))
        
        for coin in GameConstants.coins {
            coin.zPosition = .playerPlane
            self.addChild(coin)
        }
    }
    override func mouseDown(with event: NSEvent) {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(with delta: TimeInterval, and keys: Set<Key>) {
        guard let player = player else { return }
        
        if player.coinCount >= GameConstants.coins.count {
            self.scene?.physicsWorld.gravity.dy = GameConstants.warpSpeed
        }
        
        player.update(with: delta, and: keys)
        self.positionCamera()
    }
    func positionCamera() {
        guard let player = player, let parent = self.parent else { return }
        
        let playerPositionInFrame = self.convert(player.position, to: parent)

        // up
        if playerPositionInFrame.y > GameConstants.panUpBoundry {
            self.position.y -= playerPositionInFrame.y - GameConstants.panUpBoundry
        }
        // down
        if (playerPositionInFrame.y <= GameConstants.panDownBoundry) {
            position.y = min(0, position.y - (playerPositionInFrame.y - GameConstants.panDownBoundry))
        }
        // left
        if playerPositionInFrame.x <= GameConstants.panHorizonalMargin {
            self.position.x = min(0, self.position.x - (playerPositionInFrame.x - GameConstants.panHorizonalMargin))
        }
        // right
        let rightMargin = GameConstants.pixelWidth - GameConstants.panHorizonalMargin
        if playerPositionInFrame.x >= rightMargin {
            self.position.x = max(-GameConstants.pixelWidth, self.position.x - (playerPositionInFrame.x - rightMargin))
        }
    }
}

extension World: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let coin = (contact.bodyA.node?.name == "obstacle" ? contact.bodyA.node : contact.bodyB.node) as? Coin
        coin.map({ player?.collected(coin: $0) })
        coin?.wasCollected()
    }
}

extension World: PlayerPositionDelegate {
    var playerPosition: CGPoint {
        return player?.position ?? .zero
    }
}
