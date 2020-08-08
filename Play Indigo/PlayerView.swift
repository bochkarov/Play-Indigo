//
//  PlayerView.swift
//  Play Indigo
//
//  Created by Bochkarov Valentyn on 06/08/2020.
//  Copyright © 2020 Bochkarov Valentyn. All rights reserved.
//

import SwiftUI
import MediaPlayer

struct PlayerView: View {
    @Binding var musicPlayer: MPMusicPlayerController
    @State private var isPlaying = false
    
    var body: some View {
        GeometryReader { geometry in
            // 1
            VStack(spacing: 24) {
                // 2
                Image(systemName: "a.square")
                    .resizable() //3
                    .frame(width: geometry.size.width - 24, height: geometry.size.width - 24) //4
                    .cornerRadius(20)
                    .shadow(radius: 10)
                VStack(spacing: 8) {
                    Text(self.musicPlayer.nowPlayingItem?.title ?? "Not Playing")
                        .font(Font.system(.title).bold())
                    Text(self.musicPlayer.nowPlayingItem?.artist ?? "")
                        .font(.system(.headline))
                }
                HStack(spacing: 40) {
                    Button(action: {
                        // 1
                        print("Rewind")
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: 10)
                            Image(systemName: "backward.fill")
                                .foregroundColor(.white)
                                .font(.system(.title))
                        }
                    }
                    Button(action: {
                        // 1
                        if self.musicPlayer.playbackState == .paused || self.musicPlayer.playbackState == .stopped {
                            self.musicPlayer.play()
                            self.isPlaying = true
                        } else {
                            self.musicPlayer.pause()
                            self.isPlaying = false
                        }
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: 10)
                            Image(systemName: self.isPlaying ? "pause.fill" : "play.fill")
                                .foregroundColor(.white)
                                .font(.system(.title))
                        }
                    }
                    Button(action: {
                        // 1
                        print("Skip")
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: 10)
                            Image(systemName: "forward.fill")
                                .foregroundColor(.white)
                                .font(.system(.title))
                        }
                    }
                }
            }
        }
        .onAppear() {
        if self.musicPlayer.playbackState == .playing {
            self.isPlaying = true
        } else {
            self.isPlaying = false
        }
    }
    }
}

