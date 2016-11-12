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
    static let pixelToPointRatio: CGFloat = 1
    static let pixelWidth: CGFloat = 256
    static var pixelHeight: CGFloat = 384 // about 9:16
    static let windowContentSize =
        NSSize(width: pixelWidth * pixelToPointRatio,
               height: pixelHeight * pixelToPointRatio)
    static let sceneSize = CGSize(width: pixelWidth, height: pixelHeight)
    // MARK: - Textures
    static let mountainImageName = "mountain.png"
    static let playerSpriteName = "player.png"
    // MARK: - Sounds
}
