//
//  UIColorExtension.swift
//  UltimateAdBlocker
//
//  Created by Aira on 16.08.2021.
//

import Foundation
import UIKit

extension UIColor {
    enum ColorName: String {
        case mainYellow = "mainYellow"
        case mainTabBar = "mainTabBar"
        case secondaryYellow = "secondaryYellow"
        case inActiveIndicator = "inactiveIndicator"
    }
    
    class func instantinate(from colorName: ColorName) -> Self {
        return UIColor(named: colorName.rawValue) as! Self
    }
}
