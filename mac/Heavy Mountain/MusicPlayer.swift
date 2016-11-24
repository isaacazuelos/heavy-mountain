//  This is pretty inspired by SKTAudio.swift from
//  <https://github.com/raywenderlich/SKTUtils/>

import Foundation
import AVFoundation
import SpriteKit

@objc protocol PlayerPositionDelegate {
    var playerPosition: CGPoint { get }
}

class MusicPlayer: NSObject {
    
    static let SharedInstance = MusicPlayer()
    
    weak var playerPositionDelegate: PlayerPositionDelegate?
    
    var player: AVAudioPlayer?
    var track: Track = Track(number: 1)
    
    func start() {
        do {
            if let url = track.url {
                try player = AVAudioPlayer(contentsOf: url)
                player?.delegate = self
            } else {
                print("error getting url for track: \(track)")
            }
        } catch {
            print("error playing track track: \(track)")
        }
        print("playing track: \(track)")
        if GameConstants.musicPlaybackMultiplier != 1 {
            player?.enableRate = true
            player?.rate *= GameConstants.musicPlaybackMultiplier
        }
        player?.prepareToPlay()
        player?.play()
    }
}

extension MusicPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("song finished successfully: \(flag)")
        if let position = playerPositionDelegate?.playerPosition {
            track = track.next(at: position)
        }
        start()
    }
}
