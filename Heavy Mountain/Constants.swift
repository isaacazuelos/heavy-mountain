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
    static let ratio: CGFloat = 1.5
    static let pixelWidth: CGFloat = 256
    static let pixelHeight: CGFloat = 455
    
    static let zoomLevel: CGFloat = 2
    static let windowContentSize = NSSize(width: pixelWidth * ratio, height: pixelHeight * ratio)
    static let sceneSize = CGSize(width: pixelWidth, height: pixelHeight)
    // MARK: - Camera
    static let panHorizonalMargin: CGFloat = pixelWidth * 0.2
    static let panUpBoundry: CGFloat = pixelHeight * 0.8
    static let panDownBoundry: CGFloat = pixelHeight * 0.2
    // MARK: - Player Details
    static let playerSize = CGSize(width: 16, height: 16)
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
    static let gravityStrength:          CGFloat = -4
    static let playerImpulseVertical:    CGFloat = 0.08
    static let playerImpulseHorizontal:  CGFloat = 0.05
    static let playerMaxHorizontalSpeed: CGFloat = 150
    static let playerMaxSpeedUp:         CGFloat = 150
    static let playerMaxSpeedDown:       CGFloat = 350
    static let playerFiction:            CGFloat = 3
    // MARK: - Coins
    static let coinBoost: CGFloat = 100
    static let coins = [
        // Cloud
        Coin(imageNamed: "ball.png", position: CGPoint(x:128,  y:190), with: SoundEffect(fileName: "01. CLOUD1.WAV")),
        Coin(imageNamed: "ball.png", position: CGPoint(x:100, y:270), with: SoundEffect(fileName: "02. CLOUD2.WAV")),
        Coin(imageNamed: "ball.png", position: CGPoint(x:20, y:80), with: SoundEffect(fileName: "03. CLOUD3.WAV")),
        Coin(imageNamed: "ball.png", position: CGPoint(x:233, y:190), with: SoundEffect(fileName: "04. CLOUD4.WAV")),
        
    ]
}
