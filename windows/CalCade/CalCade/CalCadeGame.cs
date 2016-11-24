using System;
using System.Collections;
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Graphics;
using System.IO;
using Microsoft.Xna.Framework.Media;
using Microsoft.Xna.Framework.Audio;

namespace CalCade
{
    class TextureInfo
    {
        public string Name;
        public Texture2D Texture;

        public TextureInfo(string file, Texture2D texture)
        {
            this.Name = file;
            this.Texture = texture;
        }
    }

    class CalCadeGame : Game
    {
        bool FullScreenMode = false;

        GraphicsDeviceManager graphicsDeviceManager;
        public static Texture2D Pixel;

        float spaceAtTopOfMap = 1000;
        Vector2 mapSize;

        float pixelWidth = 512f;//256f;
        float pixelHeight = 910f;//455f;
        float backgroundZoom = 2f;
        float backgroundScale;
        Vector2 screenSize = new Vector2(1920, 1080);
        KeyboardState keyboardState, lastKeyboardState;

        public static Random Random;

        Texture2D background, mountain, boundaries, beyond;

        Player player;
        List<Coin> coins = new List<Coin>();
        List<TextureInfo> textureInfos = new List<TextureInfo>();

        Dictionary<string, SoundEffect> sounds;
        Vector2 camera = Vector2.Zero;
        MusicPlayer musicPlayer;
        SpriteFont font;

        List<SoundEffectInstance> soundsPlaying = new List<SoundEffectInstance>();
        int numCoinBoosts = 0;
        List<Texture2D> allTextures = new List<Texture2D>();

        public CalCadeGame()
        {
            player = new Player();
            Random = new Random();

            if (!FullScreenMode)
            {
                screenSize.X = pixelWidth;
                screenSize.Y = pixelHeight;
            }
            graphicsDeviceManager = new GraphicsDeviceManager(this);
            graphicsDeviceManager.PreferredBackBufferWidth = (int)screenSize.X;
            graphicsDeviceManager.PreferredBackBufferHeight = (int)screenSize.Y;
            graphicsDeviceManager.IsFullScreen = FullScreenMode;
            graphicsDeviceManager.ApplyChanges();

            coins.Add(new Coin(CoinType.mountain, new Vector2(125, 181), "cloud1"));
            coins.Add(new Coin(CoinType.mountain, new Vector2(127, 113), "cloud2"));
            coins.Add(new Coin(CoinType.mountain, new Vector2(215, 223), "cloud3"));
            coins.Add(new Coin(CoinType.mountain, new Vector2(112, 254), "cloud4"));

            coins.Add(new Coin(CoinType.cloud, new Vector2(134, 481), "cloud1"));
            coins.Add(new Coin(CoinType.cloud, new Vector2(160, 604), "cloud2"));
            coins.Add(new Coin(CoinType.cloud, new Vector2(21, 495),  "cloud3"));
            coins.Add(new Coin(CoinType.cloud, new Vector2(227, 335), "cloud4"));

            coins.Add(new Coin(CoinType.space, new Vector2(167, 770), "space1"));
            coins.Add(new Coin(CoinType.space, new Vector2(64, 724), "space2"));
            coins.Add(new Coin(CoinType.space, new Vector2(235, 883), "space3"));
            coins.Add(new Coin(CoinType.space, new Vector2(54, 905), "space4"));

            coins.Add(new Coin(CoinType.machine, new Vector2(202, 978),  "machine1"));
            coins.Add(new Coin(CoinType.machine, new Vector2(54, 944),   "machine2"));
            coins.Add(new Coin(CoinType.machine, new Vector2(104, 1058), "machine3"));
            coins.Add(new Coin(CoinType.machine, new Vector2(191, 1154), "machine4"));

            coins.Add(new Coin(CoinType.beyond, new Vector2(150, 1295), "beyond1"));
            coins.Add(new Coin(CoinType.beyond, new Vector2(93, 1329),  "beyond2"));
            coins.Add(new Coin(CoinType.beyond, new Vector2(212, 1537), "beyond3"));
            coins.Add(new Coin(CoinType.beyond, new Vector2(48, 1510),  "beyond4"));

            coins.Add(new Coin(CoinType.beyond, new Vector2(119, 1682), "beyond1"));
            coins.Add(new Coin(CoinType.beyond, new Vector2(74, 1772),  "beyond2"));
            coins.Add(new Coin(CoinType.beyond, new Vector2(204, 1650), "beyond3"));
            coins.Add(new Coin(CoinType.beyond, new Vector2(184, 1868), "beyond4"));
        }

        protected override void LoadContent()
        {
            Pixel = new Texture2D(graphicsDeviceManager.GraphicsDevice, 1, 1);
            Color[] pixelData = new Color[1];
            pixelData[0] = new Color(1f, 1f, 1f);
            Pixel.SetData(pixelData);

            background = GetTexture("background");
            mountain = GetTexture("mountain");
            boundaries = GetTexture("boundries");
            beyond = GetTexture("beyond");
            
            backgroundScale = pixelWidth / background.Width * backgroundZoom;
            mapSize = (new Vector2(background.Width, background.Height)) * backgroundScale;
            mapSize.Y += spaceAtTopOfMap;

            sounds = new Dictionary<string, SoundEffect>();
            foreach (Coin coin in coins)
            {
                coin.position = GetConvertedPosition(coin.position);
                string fullSoundPath = Path.Combine("items", coin.soundName);
                LoadSound(coin.soundName, fullSoundPath);
            }

            string coinPath = Path.Combine("texture", "coins");
            foreach (var file in Directory.GetFiles(coinPath))
            {
                string storageName = Path.GetFileName(file);
                storageName = storageName.Substring(0, storageName.Length - 4);
                textureInfos.Add(new TextureInfo(storageName, GetTexture(Path.Combine("coins", storageName))));
            }

            player.Textures = new List<Texture2D>();
            player.Textures.Add(GetTexture("player-frames\\playerframe001"));
            player.Textures.Add(GetTexture("player-frames\\playerframe002"));
            player.Textures.Add(GetTexture("player-frames\\playerframe003"));
            player.Textures.Add(GetTexture("player-frames\\playerframe004"));
            player.Textures.Add(GetTexture("player-frames\\playerframe005"));
            player.Textures.Add(GetTexture("player-frames\\playerframe006"));
            player.Textures.Add(GetTexture("player-frames\\playerframe007"));
            player.Textures.Add(GetTexture("player-frames\\playerframe008"));
            player.Textures.Add(GetTexture("player-frames\\playerframe009"));

            player.position = new Vector2(
                mapSize.X / 2f,
                mapSize.Y - 300
                );
            camera = player.position;

            List<SoundEffect> songs = new List<SoundEffect>();
            songs.Add(GetSound("music\\01"));
            songs.Add(GetSound("music\\02"));
            songs.Add(GetSound("music\\03"));
            songs.Add(GetSound("music\\04"));
            songs.Add(GetSound("music\\05"));
            songs.Add(GetSound("music\\06"));
            songs.Add(GetSound("music\\07"));
            songs.Add(GetSound("music\\08"));
            songs.Add(GetSound("music\\09"));
            songs.Add(GetSound("music\\10"));
            songs.Add(GetSound("music\\11"));
            musicPlayer = new MusicPlayer(songs, this);

            font = Content.Load<SpriteFont>("HeavyMountain");
        }

        protected override void UnloadContent()
        {
            base.UnloadContent();

            foreach (SoundEffectInstance sound in soundsPlaying)
            {
                sound.Stop();
                sound.Dispose();
            }

            foreach (SoundEffect sound in sounds.Values)
            {
                sound.Dispose();
            }

            musicPlayer.Dispose();

            foreach (Texture2D texture in allTextures)
            {
                texture.Dispose();
            }
            
            Content.Dispose();
        }

        private void LoadSound(string name, string filePath)
        {
            if (!sounds.ContainsKey(name))
            {
                sounds.Add(name, GetSound(filePath));
            }
        }

        public Vector2 GetConvertedPosition(Vector2 swiftGamePosition)
        {
            Vector2 result;
            result = swiftGamePosition / (pixelWidth / background.Width);
            result.Y = mapSize.Y - result.Y;
            return result;
        }

        public void PlaySound(SoundEffect effect)
        {
            SoundEffectInstance instance = effect.CreateInstance();
            instance.Play();
            soundsPlaying.Add(instance);
        }

        public SoundEffect GetSound(string assetName)
        {
            string name = Path.Combine("sounds", assetName);
            FileStream fileStream = new FileStream(name + ".wav", FileMode.Open, FileAccess.Read);
            return SoundEffect.FromStream(fileStream);
        }

        public Texture2D GetTexture(string assetName)
        {
            string name = Path.Combine("texture", assetName);
            FileStream fileStream = new FileStream(name + ".png", FileMode.Open, FileAccess.Read);
            Texture2D result = Texture2D.FromStream(GraphicsDevice, fileStream);
            allTextures.Add(result);
            return result;
        }

        protected override void Update(GameTime gameTime)
        {
            keyboardState = Keyboard.GetState();
            if (keyboardState.IsKeyDown(Keys.Escape) || keyboardState.IsKeyDown(Keys.D5))
            {
                Exit();
            }

            musicPlayer.Update(player.position.Y);

            for (int soundsPlayingIndex = 0;
                soundsPlayingIndex < soundsPlaying.Count;
                soundsPlayingIndex++)
            {
                if (soundsPlaying[soundsPlayingIndex].State != SoundState.Playing)
                {
                    soundsPlaying[soundsPlayingIndex].Dispose();
                    soundsPlaying.RemoveAt(soundsPlayingIndex);
                    soundsPlayingIndex--;
                }
            }


            Vector2 acceleration = Vector2.Zero;

            if (coins.Count == 0)
            {
                // Note(ian): Warp speed.
                acceleration.Y -= 1000f;
            }

            float verticalImpulse = 300f;
            float horisontalImpulse = (verticalImpulse / 8f) * 5f;
            if (keyboardState.IsKeyDown(Keys.Up) || keyboardState.IsKeyDown(Keys.W))
            {
                acceleration.Y = -verticalImpulse;
                player.hasMoved = true;
            }
            if (keyboardState.IsKeyDown(Keys.Down) || keyboardState.IsKeyDown(Keys.S))
            {
                acceleration.Y = +verticalImpulse;
                player.hasMoved = true;
            }
            if (keyboardState.IsKeyDown(Keys.Left) || keyboardState.IsKeyDown(Keys.A))
            {
                acceleration.X = -horisontalImpulse;
                player.hasMoved = true;
            }
            if (keyboardState.IsKeyDown(Keys.Right) || keyboardState.IsKeyDown(Keys.D))
            {
                acceleration.X = +horisontalImpulse;
                player.hasMoved = true;
            }

            // Gravity
            if (player.hasMoved)
            {
                acceleration.Y += 100f;
            }

            if (numCoinBoosts > 0)
            {
                numCoinBoosts--;
                acceleration.Y -= 2000f;
            }

            acceleration.X += player.velocity.X * -player.drag.X;
            acceleration.Y += player.velocity.Y * -player.drag.Y;
            
            float secondsElapsed = (float)gameTime.ElapsedGameTime.TotalSeconds;
            Vector2 playerPositionDelta = (acceleration * 0.5f * (float)Math.Pow(secondsElapsed, 2)) +
                (player.velocity * secondsElapsed);

            player.position += playerPositionDelta;

            player.velocity = player.velocity + (acceleration * secondsElapsed);

            // Max Velocity
            float baseMaxSpeed = 150f;
            float maxSpeedDown = (baseMaxSpeed / 15f) * 35f;
            player.velocity.X = player.velocity.X < 0 ? (float)Math.Max(-baseMaxSpeed, player.velocity.X) : (float)Math.Min(baseMaxSpeed, player.velocity.X);
            player.velocity.Y = player.velocity.Y < 0 ? (float)Math.Max(-baseMaxSpeed, player.velocity.Y) : (float)Math.Min(maxSpeedDown, player.velocity.Y);
            
            if (player.position.X < 0)
            {
                player.position.X = 0;
            }
            if (player.position.Y < 0)
            {
                player.position.Y = 0;
            }
            if (player.position.X > mapSize.X)
            {
                player.position.X = mapSize.X;
            }
            if (player.position.Y > mapSize.Y)
            {
                player.position.Y = mapSize.Y;
            }


            int coinRestrictionIndex = (int)Math.Floor(player.coinCount / 4f);
            if (coinRestrictionIndex < Player.boundries.Length)
            {
                float maxHeight = Player.boundries[coinRestrictionIndex];
                float convertedMaxHeight = GetConvertedPosition(new Vector2(0, maxHeight)).Y;
                if (player.position.Y < convertedMaxHeight)
                {
                    player.position.Y = convertedMaxHeight;
                }
            }

            float distanceToPickupCoin = 50;
            for (int coinIndex = 0;
                coinIndex < coins.Count;
                coinIndex++)
            {
                Coin coin = coins[coinIndex];
                Vector2 vectorToCoin = coin.position - player.position;
                if (vectorToCoin.Length() < distanceToPickupCoin)
                {
                    player.coinCount++;
                    PlaySound(sounds[coin.soundName]);
                    coins.Remove(coin);
                    coinIndex--;
                    numCoinBoosts++;
                }
            }

            lastKeyboardState = keyboardState;
        }

        public bool KeyPress(Keys key)
        {
            bool result = false;
            if(lastKeyboardState != null && keyboardState.IsKeyDown(key) && !lastKeyboardState.IsKeyDown(key))
            {
                result = true;
            }
            return result;
        }
        
        protected override void Draw(GameTime gameTime)
        {
            SpriteBatch sb3 = new SpriteBatch(graphicsDeviceManager.GraphicsDevice);
            sb3.Begin();
            sb3.Draw(Pixel, new Rectangle(0, 0, (int)screenSize.X, (int)screenSize.Y), Color.Black);
            sb3.End();

            // Note(ian): Push the camera the minimum desired distance from the player.
            Vector2 playerMoveSpaceSize = new Vector2(pixelWidth, pixelHeight) * 0.75f;
            Vector2 cameraScreenMin = camera - (playerMoveSpaceSize / 2f);
            Vector2 cameraScreenMax = camera + (playerMoveSpaceSize / 2f);
            if (player.position.X < cameraScreenMin.X)
            {
                camera.X = player.position.X + playerMoveSpaceSize.X / 2f;
            }
            if (player.position.X > cameraScreenMax.X)
            {
                camera.X = player.position.X - playerMoveSpaceSize.X / 2f;
            }
            if (player.position.Y < cameraScreenMin.Y)
            {
                camera.Y = player.position.Y + (playerMoveSpaceSize.Y / 2f);
            }
            if (player.position.Y > cameraScreenMax.Y)
            {
                camera.Y = player.position.Y - (playerMoveSpaceSize.Y / 2f);
            }

            Vector2 displaySize = new Vector2(pixelWidth, pixelHeight);
            Vector2 cameraMin = displaySize / 2f;
            Vector2 cameraMax = mapSize - displaySize / 2f;
            if (camera.X < cameraMin.X)
            {
                camera.X = cameraMin.X;
            }
            if (camera.X > cameraMax.X)
            {
                camera.X = cameraMax.X;
            }
            if (camera.Y < cameraMin.Y)
            {
                camera.Y = cameraMin.Y;
            }
            if (camera.Y > cameraMax.Y)
            {
                camera.Y = cameraMax.Y;
            }

            SpriteBatch spriteBatch = new SpriteBatch(graphicsDeviceManager.GraphicsDevice);
            Vector2 shiftedCamera = camera;
            shiftedCamera -= screenSize / 2f;
            Matrix cameraMatrix = Matrix.CreateTranslation(new Vector3(-shiftedCamera.X, -shiftedCamera.Y, 0f));
            spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.NonPremultiplied, null, null, null, null, cameraMatrix);

            // Clear screen to black.
            Rectangle screenDest = new Rectangle(0, 0, graphicsDeviceManager.PreferredBackBufferWidth, graphicsDeviceManager.PreferredBackBufferHeight);
            spriteBatch.Draw(Pixel, screenDest, Color.Black);

            Vector2 backgroundPosition = new Vector2(0, spaceAtTopOfMap);
            spriteBatch.Draw(background, backgroundPosition, null, Color.White, 0f, Vector2.Zero, backgroundScale, SpriteEffects.None, 0f);

            Vector2 mountainPosition = new Vector2(0, mapSize.Y - (mountain.Height * backgroundScale));
            mountainPosition.Y += 50; // Note(ian): Trying to line it up with the video.
            spriteBatch.Draw(mountain, mountainPosition, null, Color.White, 0f, Vector2.Zero, backgroundScale, SpriteEffects.None, 0f);

            // Note(ian): The coin texture is not centered hence the custom origin.
            Vector2 coinOrigin = new Vector2(158, 96);
            float coinScale = 0.4f;
            foreach (Coin coin in coins)
            {
                Texture2D coinTexture = coin.GetTexture(textureInfos, gameTime);
                spriteBatch.Draw(coinTexture, coin.position, null, Color.White, 0f, coinOrigin, coinScale, SpriteEffects.None, 0f);
                spriteBatch.Draw(Pixel, coin.position, null, Color.BlueViolet, 0f, Vector2.Zero, 2f, SpriteEffects.None, 0f);
            }

            Texture2D playerTexture = player.GetCurrentTexture(gameTime);
            Vector2 playerOrigin = new Vector2(playerTexture.Width / 2f, playerTexture.Height / 2f);
            float playerScale = backgroundScale * 0.5f;
            float playerRotation = (float)Math.Atan2(player.velocity.X, -player.velocity.Y);
            if (!player.hasMoved)
            {
                playerRotation = 0f;
            }
            spriteBatch.Draw(playerTexture, player.position, null, Color.White, playerRotation, playerOrigin, playerScale, SpriteEffects.None, 0f);
            
            Vector2 boundariesPosition = new Vector2(0, mapSize.Y - (boundaries.Height * backgroundScale));
            spriteBatch.Draw(boundaries, boundariesPosition, null, Color.White, 0f, Vector2.Zero, backgroundScale, SpriteEffects.None, 0f);

            Vector2 beyondPosition = new Vector2(0, spaceAtTopOfMap + (1000 * backgroundScale));
            spriteBatch.Draw(beyond, beyondPosition, null, Color.White, 0f, Vector2.Zero, backgroundScale, SpriteEffects.None, 0f);
            
            spriteBatch.End();

            SpriteBatch sb2 = new SpriteBatch(graphicsDeviceManager.GraphicsDevice);
            sb2.Begin();
            Vector2 topleft = new Vector2((screenSize.X - pixelWidth) / 2f, (screenSize.Y - pixelHeight) / 2f);
            
            Vector2 scorePosition = topleft + new Vector2(5, 5);
            sb2.DrawString(font, "crystals: " + player.coinCount, scorePosition, Color.White);

            if (FullScreenMode)
            {
                sb2.Draw(Pixel, GetRectangle(0, 0, screenSize.X, topleft.Y), Color.Black);
                sb2.Draw(Pixel, GetRectangle(0, 0, topleft.X, screenSize.Y), Color.Black);
                sb2.Draw(Pixel, GetRectangle(0, topleft.Y + pixelHeight, screenSize.X, topleft.Y), Color.Black);
                sb2.Draw(Pixel, GetRectangle(topleft.X + pixelWidth, 0, topleft.X, screenSize.Y), Color.Black);
            }

            // Note(ian): Debug screen boundary lines.
            if (false)
            {
                sb2.Draw(Pixel, new Rectangle((int)topleft.X, (int)topleft.Y, 1, (int)pixelHeight), Color.LimeGreen);
                sb2.Draw(Pixel, new Rectangle((int)topleft.X, (int)topleft.Y, (int)pixelWidth, 1), Color.LimeGreen);
                sb2.Draw(Pixel, new Rectangle((int)(topleft.X + pixelWidth), (int)topleft.Y, 1, (int)pixelHeight), Color.LimeGreen);
                sb2.Draw(Pixel, new Rectangle((int)topleft.X, (int)(topleft.Y + pixelHeight), (int)pixelWidth, 1), Color.LimeGreen);
            }

            sb2.End();
        }

        public static Rectangle GetRectangle(float x, float y, float width, float height)
        {
            return new Rectangle((int)x, (int)y, (int)width, (int)height);
        }

        public Rectangle GetCenteredRectangleDestination(Vector2 position, float size)
        {
            float halfSize = size / 2f;
            return GetRectangle(position.X - halfSize, position.Y - halfSize, size, size);
        }
    }
}
