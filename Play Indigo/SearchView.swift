//
//  SearchView.swift
//  Play Indigo
//
//  Created by Bochkarov Valentyn on 06/08/2020.
//  Copyright © 2020 Bochkarov Valentyn. All rights reserved.
//

import SwiftUI
import StoreKit
import MediaPlayer

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults = [Song]()
    @Binding var musicPlayer: MPMusicPlayerController
    
    var body: some View {
        VStack {
            TextField("Search Songs", text: $searchText, onCommit: {
                // 1
                UIApplication.shared.resignFirstResponder()
                if self.searchText.isEmpty {
                    // 2
                    self.searchResults = []
                } else {
                    // 3
                    SKCloudServiceController.requestAuthorization { (status) in
                        if status == .authorized {
                            // 4
                            self.searchResults = AppleMusicAPI().searchAppleMusic(self.searchText)
                        }
                    }
                }
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 16)
                .accentColor(.pink)
            
            List {
                // 1
                ForEach(searchResults, id:\.id) { song in
                    // 2
                    HStack {
                        // 3
                        Image(systemName: "rectangle.stack.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(5)
                            .shadow(radius: 2)
                        
                        // 4
                        VStack(alignment: .leading) {
                            Text(song.name)
                                .font(.headline)
                            Text(song.artistName)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        // 5
                        Button(action: {
                            self.musicPlayer.setQueue(with: [song.id])
                            self.musicPlayer.play()
                        }) {
                            Image(systemName: "play.fill")
                                .foregroundColor(.pink)
                        }
                    }
                }
            }
            .accentColor(.pink)
        }
    }
}

