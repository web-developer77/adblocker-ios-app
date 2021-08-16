//
//  UDManager.swift
//  AdBlockProtect
//
//  Created by Macintosh on 17.12.2020.
//

import UIKit

class UDManager: NSObject {
    
    func setAppLaunch(count: Int) {
        UserDefaults.standard.set(count, forKey: "AppLaunchCounts")
    }
    
    func getAppLaunchCounts() -> Int {
        return UserDefaults.standard.integer(forKey: "AppLaunchCounts")
    }

}
