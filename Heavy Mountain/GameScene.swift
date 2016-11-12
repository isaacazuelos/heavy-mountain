//
//  GameScene.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let lastTime: TimeInterval = 0.0
    // our world node, which we pan to move the world relative to the camera/scene
    let world = World()
    // our hud node, which is fixed relative to the scene
    let hud = SKNode()
    
    var keysPressed = Set<Key>()
    
//    let player = Player(position: CGPoint(x:120, y:120))
    
    override func willMove(from view: SKView) {
        size = CGSize(width: GameConstants.pixelWidth, height: GameConstants.pixelHeight)
    }
    override func didMove(to view: SKView) {
        anchorPoint = .zero
        scaleMode = .fill
        self.size = GameConstants.sceneSize
    
        self.addChild(world)
        self.addChild(hud)
        
        world.player = Player(position: CGPoint(x:120, y:120))
        
        let mountain = BackgroundSprite(imageNamed: GameConstants.mountainImageName)
        mountain.name = "mountain"
        world.addChild(mountain)
    }
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - lastTime
        world.update(with: delta, and: keysPressed)
    }
    
    // MARK: - Inputs
    override func keyDown(with event: NSEvent) {
        let keyCode = event.keyCode
        if let key = Key(rawValue: keyCode) {
            keysPressed = keysPressed.union([key])
        } else {
            print("unknown key pressed: \(event)")
        }
    }
    
    override func keyUp(with event: NSEvent) {
        if let key = Key(rawValue: event.keyCode) {
            keysPressed.remove(key)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        let pos = event.location(in: self)
        print("click at: \(pos)")
    }
}
