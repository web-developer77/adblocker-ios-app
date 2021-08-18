//
//  ActivateModel.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import Foundation
import UIKit

struct ActivateModel {
    
    let text: String
    let image: UIImage
}


extension ActivateModel {
    static let defaultModel = [
        ActivateModel(text: "Open Settings", image: UIImage.instantinate(from: .settimgImg)),
        ActivateModel(text: "Open Safari Settings", image: UIImage.instantinate(from: .safariImg)),
        ActivateModel(text: "Search For Content \nBlockers", image: UIImage.instantinate(from: .secureImg)),
//        ActivateModel(text: "ALLOW ALL CONTENT BLOCKERS", imageName: "4a"),
    ]
    
}
