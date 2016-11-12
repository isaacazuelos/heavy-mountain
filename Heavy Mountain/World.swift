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
    
    static let panUpBoundry: CGFloat = 300.0
    static let panDownBoundry: CGFloat = 50.0
    
    override init() {
        super.init()
        self.name = "world"
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
                self.addChild($0)
            }
        }
    }
    
    func update(with delta: TimeInterval, and keys: Set<Key>) {
        guard let player = player else { return }
        
        while self.convert(player.position, to: parent!).y > World.panUpBoundry {
            self.position.y -= 1
        }

        while self.convert(player.position, to: parent!).y < World.panDownBoundry {
            self.position.y += 1
        }
        
        player.update(with: delta, and: keys)
    }
}
