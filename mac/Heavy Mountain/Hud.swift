import Foundation
import SpriteKit

class Hud: SKNode {

    let coinCountLabel: SKLabelNode
    
    override init() {
        coinCountLabel = SKLabelNode(fontNamed: "Futura")
        
        coinCountLabel.fontSize = 12
        coinCountLabel.verticalAlignmentMode = .top
        coinCountLabel.horizontalAlignmentMode = .left
        
        let y = Int(floor(GameConstants.pixelHeight))
        
        coinCountLabel.position = CGPoint(x: 0, y: y)
        coinCountLabel.zPosition = 100000000
        super.init()
        addChild(coinCountLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with world: World) {
        coinCountLabel.text = "crystals: \(world.player?.coinCount ?? 0)"
    }
}
