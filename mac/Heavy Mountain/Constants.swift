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
    static let mountainImageName = "mountain"
    static let playerSpriteName = "player"
    static let mountainBackground = "world-1-bg"
    static let cloudBackground = "world-2-bg"
    // MARK: - Sounds
    static let musicPlaybackMultiplier: Float = 1.0
    // MARK: - Physics
    static let gravityStrength:          CGFloat = -4
    static let playerImpulseVertical:    CGFloat = 0.08
    static let playerImpulseHorizontal:  CGFloat = 0.05
    static let playerMaxHorizontalSpeed: CGFloat = 150
    static let playerMaxSpeedUp:         CGFloat = 150
    static let playerMaxSpeedDown:       CGFloat = 350
    static let playerFiction:            CGFloat = 3
    static let warpBarrier:              CGFloat = 2000
    static let warpSpeed:                CGFloat = 200
    // MARK: - Coins
    static let coinBoost: CGFloat = 10000
    static let coinSize = CGSize(width: 64, height: 64)
    static let coins = [
        // 1 mountain
        Coin(type: .mountain, position: CGPoint(x:125, y:181),  with: SoundEffect(fileName: "cloud1.wav")),
        Coin(type: .mountain, position: CGPoint(x:127, y:113),  with: SoundEffect(fileName: "cloud2.wav")),
        Coin(type: .mountain, position: CGPoint(x:15,  y:223),  with: SoundEffect(fileName: "cloud3.wav")),
        Coin(type: .mountain, position: CGPoint(x:112, y:254),  with: SoundEffect(fileName: "cloud4.wav")),
        // 2 cloud
        Coin(type: .cloud,    position: CGPoint(x:134, y:481),  with: SoundEffect(fileName: "cloud1.wav")),
        Coin(type: .cloud,    position: CGPoint(x:160, y:604),  with: SoundEffect(fileName: "cloud2.wav")),
        Coin(type: .cloud,    position: CGPoint(x:21,  y:495),  with: SoundEffect(fileName: "cloud3.wav")),
        Coin(type: .cloud,    position: CGPoint(x:227, y:335),  with: SoundEffect(fileName: "cloud4.wav")),
        // 3 space
        Coin(type: .space,    position: CGPoint(x:167, y:770),  with: SoundEffect(fileName: "space1.wav")),
        Coin(type: .space,    position: CGPoint(x:64,  y:724),  with: SoundEffect(fileName: "space2.wav")),
        Coin(type: .space,    position: CGPoint(x:235, y:883),  with: SoundEffect(fileName: "space3.wav")),
        Coin(type: .space,    position: CGPoint(x:54,  y:905),  with: SoundEffect(fileName: "space4.wav")),
        // 4 machine
        Coin(type: .machine,  position: CGPoint(x:202, y:978),  with: SoundEffect(fileName: "machine1.wav")),
        Coin(type: .machine,  position: CGPoint(x:54,  y:944),  with: SoundEffect(fileName: "machine2.wav")),
        Coin(type: .machine,  position: CGPoint(x:104, y:1058), with: SoundEffect(fileName: "machine3.wav")),
        Coin(type: .machine,  position: CGPoint(x:191, y:1154), with: SoundEffect(fileName: "machine4.wav")),
        // 5 beyond
        Coin(type: .beyond,   position: CGPoint(x:150, y:1295), with: SoundEffect(fileName: "beyond1.wav")),
        Coin(type: .beyond,   position: CGPoint(x:93,  y:1329), with: SoundEffect(fileName: "beyond2.wav")),
        Coin(type: .beyond,   position: CGPoint(x:212, y:1537), with: SoundEffect(fileName: "beyond3.wav")),
        Coin(type: .beyond,   position: CGPoint(x:48,  y:1510), with: SoundEffect(fileName: "beyond4.wav")),
        // 6 void
        Coin(type: .beyond,   position: CGPoint(x:119, y:1682), with: SoundEffect(fileName: "beyond1.wav")),
        Coin(type: .beyond,   position: CGPoint(x:74,  y:1772), with: SoundEffect(fileName: "beyond2.wav")),
        Coin(type: .beyond,   position: CGPoint(x:204, y:1650), with: SoundEffect(fileName: "beyond3.wav")),
        Coin(type: .beyond,   position: CGPoint(x:184, y:1868), with: SoundEffect(fileName: "beyond4.wav")),
    ]
}
