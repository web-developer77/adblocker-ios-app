//
//  KCHManager.swift
//  RemoveAds
//
//  Created by Macintosh on 11.11.2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import KeychainSwift

class KeychainDataManager {
    
    // - wh
    func isCl() -> Bool {
        let keychain = KeychainSwift()
        return keychain.getBool("cl") ?? false
    }
    
    func setIsCl() {
        let keychain = KeychainSwift()
        setDT(dt: "....")
        keychain.set(true, forKey: "cl")
    }
    
    // -
    func set(date: String) {
        let keychain = KeychainSwift()
        keychain.set(date, forKey: "date1", withAccess: nil)
    }
    
    func getDate() -> String {
        let keychain = KeychainSwift()
        return keychain.get("date1") ?? ""
    }
    
    // - dt
    func dataIsLoaded() -> Bool {
        let keychain = KeychainSwift()
        let str = keychain.get("dt") ?? ""
        return !str.isEmpty
    }
    
    func setDT(dt: String) {
        let keychain = KeychainSwift()
        keychain.set(dt, forKey: "dt")
    }
    
    func dt() -> String {
        let keychain = KeychainSwift()
        return keychain.get("dt") ?? ""
    }

}
