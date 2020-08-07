//
//  AppleMusicAPI.swift
//  Play Indigo
//
//  Created by Bochkarov Valentyn on 07/08/2020.
//  Copyright © 2020 Bochkarov Valentyn. All rights reserved.
//

import StoreKit

class AppleMusicAPI {
    
    let developerToken = "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ijg0NFk0SzhMUTcifQ.eyJpc3MiOiJWR0FTTUROVVg0IiwiaWF0IjoxNTk2NzM5NDM4LCJleHAiOjE2MTI1MTEwMzh9.PDPGtYR5Vo0Ed2gb7KALbffvNzany3LDNRR7FpmbfOF7PJ22GQtpknqVQSli65XEjefC2NfwkFrOdNz5d4WYlQ"
    
    func getUserToken() -> String {
        var userToken = String()
        
        // 1
        let lock = DispatchSemaphore(value: 0)
        
        // 2
        SKCloudServiceController().requestUserToken(forDeveloperToken: developerToken) { (receivedToken, error) in
            // 3
            guard error == nil else { return }
            if let token = receivedToken {
                userToken = token
                lock.signal()
            }
        }
        // 4
        lock.wait()
        return userToken
    }
    
    func fetchStorefrontID() -> String {
        // 1
        let lock = DispatchSemaphore(value: 0)
        var storefrontID: String!
        
        // 2
        let musicURL = URL(string: "https://api.music.apple.com/v1/me/storefront")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue(getUserToken(), forHTTPHeaderField: "Music-User-Token")
        
        // 3
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else { return }
            
            // 4
            if let json = try? JSON(data: data!) {
                
                // 1
                let result = (json["data"]).array!
                let id = (result[0].dictionaryValue)["id"]!
                
                // 2
                storefrontID = id.stringValue
                
                // 3
                lock.signal()
            }
        }.resume()
        // 5
        lock.wait()
        return storefrontID
    }
}
