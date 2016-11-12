//
//  World.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation
import SpriteKit

class World: SKNode {
    
    override init() {
        super.init()
        self.name = "world"
        
        // mountain
        let mountain = BackgroundSprite(imageNamed: GameConstants.mountainImageName)
        mountain.zPosition = 10
        mountain.name = "mountain"
        addChild(mountain)
        
        // add background
        let mountainBackground = BackgroundSprite(imageNamed: GameConstants.mountainBackground)
        mountainBackground.zPosition = 5
        let cloudBackground = BackgroundSprite(imageNamed: GameConstants.cloudBackground)
        cloudBackground.zPosition = 7
        addChild(mountainBackground)
        addChild(cloudBackground)
        
        // player
        player = Player(position: CGPoint(x:120, y:160))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var player: Player? {
        get { return self.childNode(withName: "player") as? Player }
        set {
            self.removeChildren(in: children.filter { $0.name == "player" })
            newValue.map {
                $0.name = "player"
                $0.zPosition = 100
                self.addChild($0)
            }
        }
    }
    
    func update(with delta: TimeInterval, and keys: Set<Key>) {
        if keys.contains(Key.r) { // remove all balls
            removeChildren(in: children.filter { $0.name == "ball"})
        }
        
        guard let player = player else { return }
        player.update(with: delta, and: keys)
        self.positionCamera()
    }
    
    override func mouseDown(with event: NSEvent) {
        let ball = Obstacle(imageNamed: GameConstants.ballName)
        ball.name = "ball"
        ball.position = event.location(in: self)
        ball.zPosition = 100
        addChild(ball)
    }
    
    func positionCamera() {
        guard let player = player else { return }
        
        let playerPositionInFrame = self.convert(player.position, to: parent!)

        if playerPositionInFrame.y > GameScene.panUpBoundry {
            self.position.y -= playerPositionInFrame.y - GameScene.panUpBoundry
        }
        if (playerPositionInFrame.y < GameScene.panDownBoundry)
                && (player.position.y > GameScene.panDownBoundry) {
            self.position.y += GameScene.panDownBoundry - playerPositionInFrame.y
        }
        // TODO: Fix properly
        // right now, when moving down, there's an issue if the player just get's slammed down into the bottom, where it doesn't pan the world down all the way. This is just a cheap, but chop-inducing fix.
        if player.position.y == 0 {
            self.position.y = 0
        }
    }
}

extension World: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact: \(contact)")
    }
}
