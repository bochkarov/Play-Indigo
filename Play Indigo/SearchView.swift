//
//  SearchView.swift
//  Play Indigo
//
//  Created by Bochkarov Valentyn on 06/08/2020.
//  Copyright © 2020 Bochkarov Valentyn. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    let songs = ["Volnami", "Kaif", "Tam Lesa", "ChP Lyubvi"]
    var body: some View {
        VStack {
            TextField("Search Songs", text: $searchText, onCommit: {
                print(self.searchText)
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 16)
                .accentColor(.pink)
            
            List {
                // 1
                ForEach(songs, id:\.self) { songTitle in
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
                            Text(songTitle)
                                .font(.headline)
                            Text("Artist Name")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        // 5
                        Button(action: {
                            print("Playing \(songTitle)")
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
