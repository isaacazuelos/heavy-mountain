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

    var mountain: BackgroundSprite!
    
    override func willMove(from view: SKView) {
        size = CGSize(width: GameConstants.pixelWidth, height: GameConstants.pixelHeight)
    }
    
    override func didMove(to view: SKView) {
        anchorPoint = .zero
        scaleMode = .fill
        self.size = GameConstants.sceneSize
        
        mountain = BackgroundSprite(imageNamed: GameConstants.mountainImageName)
        self.addChild(mountain)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0: // 'a'
            print(self.size)
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
}
