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
