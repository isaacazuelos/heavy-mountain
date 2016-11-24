////
////  Obstacle.swift
////  Heavy Mountain
////
////  Created by Isaac Azuelos on 2016-11-12.
////  Copyright © 2016 Isaac Azuelos. All rights reserved.
////

using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CalCade
{
    enum CoinType
    {
        mountain,
        cloud,
        space,
        machine,
        beyond
    }

    class Coin
    {
        public CoinType type;
        public Vector2 position;
        public string soundName;
        
        public Coin(CoinType type, Vector2 position, string soundName)
        {
            this.type = type;
            this.position = position;
            this.soundName = soundName;
        }
        
        public Texture2D GetTexture(List<TextureInfo> textures, GameTime gameTime)
        {
            Texture2D result;

            string textureName = "";
            switch (type)
            {
            case CoinType.mountain:
                textureName = "W1";
                break;
            case CoinType.cloud:
                textureName = "W2";
                break;
            case CoinType.space:
                textureName = "W3";
                break;
            case CoinType.machine:
                textureName = "W4";
                break;
            case CoinType.beyond:
                textureName = "W5";
                break;
            }

            float frameTime = 0.2f;
            int numFrames = 12;
            int frame = (int)Math.Floor(gameTime.TotalGameTime.TotalSeconds / frameTime);
            frame %= numFrames;
            frame++;
            textureName += "Frame" + frame.ToString("D3");

            result = textures.First(x => x.Name == textureName).Texture;

            return result;
        }
    }
}