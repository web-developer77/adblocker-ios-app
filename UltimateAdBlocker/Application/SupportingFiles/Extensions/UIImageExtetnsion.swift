//
//  UIImageExtetnsion.swift
//  UltimateAdBlocker
//
//  Created by Aira on 16.08.2021.
//

import Foundation
import UIKit

extension UIImage {
    
    enum  ImageName: String {
        case selectedTabGeneral = "ic_general_selected"
        case unselectedTabGeneral = "ic_general_unselected"
        case selectedTabGuide = "ic_guide_selected"
        case unselectedTabGuide = "ic_guide_unselected"
        case selectedTabSetting = "ic_setting_selected"
        case unselectedTabSetting = "ic_setting_unselected"
        case settimgImg = "ic_setting"
        case safariImg = "ic_safari"
        case secureImg = "ic_secure"
        case contactImg = "ic_contact"
        case termsImg = "ic_terms"
        case privacyImg = "ic_privacy"
        case premiumAD = "ic_premium_ad"
        case premiumVirus = "ic_premium_virus"
        case premiumTrack = "ic_premium_track"
        case premiumTrail = "ic_premium_trailing"
    }
    
    class func instantinate(from imageName: ImageName) -> Self {
        return UIImage(named: imageName.rawValue) as! Self
    }
}
