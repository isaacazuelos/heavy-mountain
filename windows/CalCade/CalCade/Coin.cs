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
                textureName = "w1";
                break;
            case CoinType.cloud:
                textureName = "w2";
                break;
            case CoinType.space:
                textureName = "w3";
                break;
            case CoinType.machine:
                textureName = "w4";
                break;
            case CoinType.beyond:
                textureName = "w5";
                break;
            }

            float frameTime = 0.2f;
            int numFrames = 12;
            int frame = (int)Math.Floor(gameTime.TotalGameTime.TotalSeconds / frameTime);
            frame %= numFrames;
            frame++;
            textureName += "frame" + frame.ToString("D3");

            result = textures.First(x => x.Name == textureName).Texture;

            return result;
        }
    }
}