//  This is pretty inspired by SKTAudio.swift from
//  <https://github.com/raywenderlich/SKTUtils/>

using System.Collections.Generic;
using Microsoft.Xna.Framework.Audio;
using CalCade;
using System;

class MusicPlayer
{
    float transition3 = 618;
    float transition4 = 907;
    float transition7 = 1195;
    float transition8 = 2000;
    float transition10 = 5000;

    List<SoundEffect> songs;
    int currentTrackNumber = 1;
    SoundEffectInstance currentSong;

    public MusicPlayer(List<SoundEffect> songs, CalCadeGame game)
    {
        this.songs = songs;
        currentSong = songs[currentTrackNumber - 1].CreateInstance();
        currentSong.Play();

        transition3 = game.GetConvertedPosition(new Microsoft.Xna.Framework.Vector2(0, transition3)).Y;
        transition4 = game.GetConvertedPosition(new Microsoft.Xna.Framework.Vector2(0, transition4)).Y;
        transition7 = game.GetConvertedPosition(new Microsoft.Xna.Framework.Vector2(0, transition7)).Y;
        transition8 = game.GetConvertedPosition(new Microsoft.Xna.Framework.Vector2(0, transition8)).Y;
        transition10 = game.GetConvertedPosition(new Microsoft.Xna.Framework.Vector2(0, transition10)).Y;
    }

    public void Update(float playerY)
    {
        if (currentSong.State == SoundState.Stopped)
        {
            int nextTrackNumber;
            switch (currentTrackNumber)
            {
            case 1:
                nextTrackNumber = 2;
                break;
            case 2:
                nextTrackNumber = 3;
                break;
            case 3:
                nextTrackNumber = playerY <= transition3 ? 4 : 3;
                break;
            case 4:
                nextTrackNumber = playerY <= transition4 ? 5 : 4;
                 break;
            case 5:
                nextTrackNumber = 6;
                break;
            case 6:
                nextTrackNumber = 7;
                break;
            case 7:
                nextTrackNumber = playerY <= transition7 ? 8 : 7;
                break;
            case 8:
                nextTrackNumber = playerY <= transition8 ? 9 : 8;
                break;
            case 9:
                nextTrackNumber = 10;
                break;
            case 10:
                nextTrackNumber = 11;
                break;
            default:
                nextTrackNumber = 0;
                break;
            }

            if (nextTrackNumber == currentTrackNumber)
            {
                if (currentTrackNumber != 0)
                {
                    currentSong.Play();
                    //Console.WriteLine("Replaying track " + currentTrackNumber);
                }
            }
            else
            {
                currentSong.Dispose();
                currentTrackNumber = nextTrackNumber;
                if (currentTrackNumber != 0)
                {
                    currentSong = songs[currentTrackNumber - 1].CreateInstance();
                    currentSong.Play();
                }
                //Console.WriteLine("Switching to track " + currentTrackNumber);
            }
        }
    }

    internal void Dispose()
    {
        if (currentSong != null && currentSong.State == SoundState.Playing)
        {
            currentSong.Stop();
        }

        foreach (SoundEffect song in songs)
        {
            song.Dispose();
        }
    }
}
