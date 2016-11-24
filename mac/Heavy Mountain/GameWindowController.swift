//
//  GameWindowController.swift
//  Heavy Mountain
//
//  Created by Isaac Azuelos on 2016-11-11.
//  Copyright © 2016 Isaac Azuelos. All rights reserved.
//

import Cocoa

class GameWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.setContentSize(GameConstants.windowContentSize)
    }
}
