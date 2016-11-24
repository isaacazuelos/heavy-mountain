////
////  Player.swift
////  Heavy Mountain
////
////  Created by Isaac Azuelos on 2016-11-11.
////  Copyright © 2016 Isaac Azuelos. All rights reserved.
////

using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;

namespace CalCade
{
    class Player
    {
        public static float[] boundries = new float[] { 265, 618, 907, 1195, 1563 };

        public bool hasMoved = false;
        public int coinCount;

        public Vector2 position;
        public Vector2 velocity;
        public Vector2 drag = new Vector2(1f, 1f);

        public List<Texture2D> Textures;

        public Texture2D GetCurrentTexture(GameTime gameTime)
        {
            float frameTime = 0.2f;;
            int frame = (int)Math.Floor(gameTime.TotalGameTime.TotalSeconds / frameTime);
            frame %= Textures.Count;
            return Textures[frame];
        }
        
        //        self.physicsBody?.affectedByGravity = false // set to true when they try to lift off.
        //        self.physicsBody?.linearDamping = GameConstants.playerFiction

        //public void clampPositionInGame()
        //{
            //        if let body = self.physicsBody {
            //            if self.position.x <= 0 {
            //                body.velocity.dx = max(body.velocity.dx, 0)
            //                self.position.x = 0
            //            }
            //            if self.position.x >= GameConstants.pixelWidth {
            //                body.velocity.dx = min(body.velocity.dx, 0)
            //                self.position.x = GameConstants.pixelWidth
            //            }
            //            if self.position.y <= 0 {
            //                body.velocity.dy = max(body.velocity.dy, 0)
            //                self.position.y = 0
            //            }
            //        }
        //}

        //    func clampVerticalVelocity() {
        //        if let dy = self.physicsBody?.velocity.dy {
        //            self.physicsBody?.velocity.dy = dy >= 0
        //                ? min(GameConstants.playerMaxSpeedUp, dy)
        //                : max(-GameConstants.playerMaxSpeedDown, dy)
        //        }
        //    }

        //    func clampHorizontalVelocity() {
        //        if let dx = self.physicsBody?.velocity.dx {
        //            self.physicsBody?.velocity.dx = dx >= 0
        //                ? min(GameConstants.playerMaxHorizontalSpeed,  dx)
        //                : max(-GameConstants.playerMaxHorizontalSpeed, dx)
        //        }

        //    }

        //    func setRotation() {

        //        if !hasGoneUp {
        //            self.zRotation = 0
        //            return
        //        }

        //        guard let x = self.physicsBody?.velocity.dx else { return }
        //        guard let y = self.physicsBody?.velocity.dy else { return }
        //        self.zRotation = atan2(y, x) - (CGFloat.pi / 2)
        //    }

        //    func update(with delta: TimeInterval, and keys: Set<Key>) {

        //        if keys.contains(Key.r) { coinCount += 1 }

        //        if !hasGoneUp && keys.contains(Key.up) {
        //            hasGoneUp = true
        //            self.physicsBody?.affectedByGravity = true
        //        }

        //        var impulse = GameConstants.playerImpulseVertical
        //        if keys.contains(Key.b) {
        //            impulse *= 2
        //        }

        //        if keys.contains(Key.up) && !keys.contains(Key.down){
        //            self.physicsBody?.applyImpulse(CGVector(dx:0.0, dy:impulse))
        //        }
        //        if keys.contains(Key.down) && !keys.contains(Key.up) {
        //            self.physicsBody?.applyImpulse(CGVector(dx:0.0, dy:-impulse))
        //        }

        //        impulse = GameConstants.playerImpulseHorizontal

        //        if keys.contains(Key.right) && !keys.contains(Key.left) {
        //            self.physicsBody?.applyImpulse(CGVector(dx:impulse, dy:0.0))
        //        }
        //        if keys.contains(Key.left) && !keys.contains(Key.right) {
        //            self.physicsBody?.applyImpulse(CGVector(dx:-impulse, dy:0.0))

        //        }
        //        if !keys.contains(Key.b) { clampVerticalVelocity() }
        //        clampHorizontalVelocity()
        //        clampPositionInGame()
        //        if !keys.contains(Key.b) { applyCoinRestrictions() }

        //        setRotation()
        //    }

        //    func collected(coin: Coin) {
        //        if !coin.collected { self.coinCount += 1 }
        //        self.physicsBody?.applyForce(CGVector(dx: 0.0, dy: GameConstants.coinBoost))
        //    }
        //    func applyCoinRestrictions() {
        //        if coinCount >= GameConstants.coins.count {
        //            return
        //        }
        //        let index = Int(floor(Float(coinCount) / 4.0))

        //        if index < Player.boundries.count {
        //            let maxHeight = Player.boundries[index]
        //            position.y = min(position.y, maxHeight)
        //        }
        //    }
        //}
    }
}
