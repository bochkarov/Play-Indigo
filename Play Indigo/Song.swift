//
//  Song.swift
//  Play Indigo
//
//  Created by Bochkarov Valentyn on 07/08/2020.
//  Copyright © 2020 Bochkarov Valentyn. All rights reserved.
//

import Foundation

struct Song {
    var id: String
    var name: String
    var artistName: String
    var artworkURL: String
    
    init(id: String, name: String, artistName: String, artworkURL: String ) {
        self.id = id
        self.name = name
        self.artistName = artistName
        self.artworkURL = artworkURL
    }
}
