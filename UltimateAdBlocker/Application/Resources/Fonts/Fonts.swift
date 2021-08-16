//
//  Fonts.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 02.03.2021.
//

import UIKit


enum Fonts: String {
    case comfortaaBold = "Comfortaa-Bold"
    case robotoBold = "Roboto-Bold"
    case robotoRegular = "Roboto-Regular"
    case robotoLight = "Roboto-Light"
        
    
    func of(size: CGFloat) -> UIFont? {
        guard let font = UIFont(name: self.rawValue, size: size) else { return nil }
        return font
    }
}
