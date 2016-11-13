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
    
    // the time of the last frame, used to compute the deltas
    let lastTime: TimeInterval = 0.0
    let music = MusicPlayer()
    // our world node, which we pan to move the world relative to the camera/scene
    var world = World()
    // our hud node, which is fixed relative to the scene
    let hud = Hud()
    
    var keysPressed = Set<Key>()
    
    override func didMove(to view: SKView) {
        self.scaleMode = .fill
        self.size = GameConstants.sceneSize
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: GameConstants.gravityStrength)
        
        self.world.setScale(GameConstants.zoomLevel)
        
        self.addChild(world)
        self.world.position.x = -128
        
        self.addChild(hud)
        hud.zPosition = 100000
        
        // Collisions don't really happen in the hud, so we'll make the delegate the world.
        self.physicsWorld.contactDelegate = world
        
        self.music.playerPositionDelegate = world
        self.music.start()
    }
    
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - lastTime
        world.update(with: delta, and: keysPressed)
        hud.update(with: world)
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
        let pos = event.location(in: world)
        print("clicked at: \(pos)")
        world.mouseDown(with: event)
    }
}
