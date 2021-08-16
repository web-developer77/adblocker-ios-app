//
//  ActivateModel.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import Foundation


struct ActivateModel {
    
    let text: String
    let imageName: String
}


extension ActivateModel {
    static let defaultModel = [
        ActivateModel(text: "OPEN SETTINGS", imageName: "1a"),
        ActivateModel(text: "OPEN SAFARI SETTINGS", imageName: "2a"),
        ActivateModel(text: "SEARCH FOR CONTENT BLOCKERS", imageName: "3a"),
        ActivateModel(text: "ALLOW ALL CONTENT BLOCKERS", imageName: "4a"),
    ]
    
}
