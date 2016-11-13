//
//  SoundEffect.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-12.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import SpriteKit

struct SoundEffect {
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func play(on node: SKNode) {
        node.run(SKAction.playSoundFileNamed(self.fileName, waitForCompletion: false))
    }
}
