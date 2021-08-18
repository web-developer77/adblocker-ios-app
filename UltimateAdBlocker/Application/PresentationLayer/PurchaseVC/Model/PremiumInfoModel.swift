//
//  PremiumInfoModel.swift
//  UltimateAdBlocker
//
//  Created by Aira on 17.08.2021.
//

import Foundation
import UIKit

enum PremiumInfoModel: Int, CustomStringConvertible, CaseIterable {  
    
    case AD
    case Virus
    case Track
   
    var title: String {
        switch self {
        case .AD: return "Stop ads"
        case .Virus: return "Block Viruses"
        case .Track: return "Stop Tracking"
        }
    }
    
    var description: String {
        switch self {
        case .AD: return "Disable useless ads"
        case .Virus: return "Disable useless ads"
        case .Track: return "Make websites respect privacy"
        }
    }
    
    var image: UIImage {
        switch self {
        case .AD: return UIImage.instantinate(from: .premiumAD)
        case .Virus: return UIImage.instantinate(from: .premiumVirus)
        case .Track: return UIImage.instantinate(from: .premiumTrack)
        }
    }

}

