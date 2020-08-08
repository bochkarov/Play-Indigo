//
//  ContentView.swift
//  Play Indigo
//
//  Created by Bochkarov Valentyn on 06/08/2020.
//  Copyright © 2020 Bochkarov Valentyn. All rights reserved.
//

import SwiftUI
import StoreKit
import MediaPlayer

struct ContentView: View {
    @State private var selection = 0
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
 
    var body: some View {
        TabView(selection: $selection){
            PlayerView(musicPlayer: self.$musicPlayer)
                .tag(0)
                .tabItem {
                    VStack {
                        Image(systemName: "music.note")
                        Text("Player")
                    }
                }
            SearchView(musicPlayer: self.$musicPlayer)
            .tag(1)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
        }
        .accentColor(.pink)
//        .onAppear() {
//            SKCloudServiceController.requestAuthorization { (status) in
//                if status == .authorized {
//                    print(AppleMusicAPI() .searchAppleMusic("Valik Indigo"))
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
