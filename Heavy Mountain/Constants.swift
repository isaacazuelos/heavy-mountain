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
    static let musicPlaybackMultiplier: Float = 1.0
    static let testSoundEffectFileName = "01. CLOUD1.WAV"
    // MARK: - Physics
    static let gravityStrength:          CGFloat = -3
    static let playerImpulseVertical:    CGFloat = 0.2
    static let playerImpulseHorizontal:  CGFloat = 0.2
    static let playerMaxHorizontalSpeed: CGFloat = 120
    static let playerMaxSpeedUp:         CGFloat = 100
    static let playerMaxSpeedDown:       CGFloat = 200
    static let playerFiction:            CGFloat = 7.5
    // MARK: - Coins
    static let coinBoost: CGFloat = 100
    static let coins = [
        // Cloud
        Coin(imageNamed: "ball.png", position: CGPoint(x:30,  y:338), with: SoundEffect(fileName: "01. CLOUD1.WAV")),
        Coin(imageNamed: "ball.png", position: CGPoint(x:209, y:350), with: SoundEffect(fileName: "02. CLOUD2.WAV")),
        Coin(imageNamed: "ball.png", position: CGPoint(x:120, y:540), with: SoundEffect(fileName: "03. CLOUD3.WAV")),
        Coin(imageNamed: "ball.png", position: CGPoint(x:250, y:440), with: SoundEffect(fileName: "04. CLOUD4.WAV")),
    ]
}
