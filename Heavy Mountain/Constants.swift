//
//  Constants.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Foundation

struct GameConstants {
    // MARK: - Sizes
    static let ratio: CGFloat = 2
    static let pixelWidth: CGFloat = 256
    static var pixelHeight: CGFloat = 384 // about 9:16
    static let windowContentSize = NSSize(width: pixelWidth * ratio, height: pixelHeight * ratio)
    static let sceneSize = CGSize(width: pixelWidth, height: pixelHeight)
    // MARK: - Textures
    static let mountainImageName = "mountain.png"
    static let playerSpriteName = "player.png"
    static let mountainBackground = "world-1-bg.png"
    static let cloudBackground = "world-2-bg.png"
    static let ballName = "ball.png"
    // MARK: - Sounds
    static let testTrack = "testTrack.mp3"
    // MARK: - Physics
    static let gravityStrength: CGFloat = -2
    static let playerImpulse: CGFloat = 0.7
    static let playerFiction: CGFloat = 10
}
