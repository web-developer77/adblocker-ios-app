
import UIKit

enum SettingsModel: Int, CustomStringConvertible, CaseIterable {
    
    case ContactUs
    case Terms
    case Privacy
//    case HelpWithSubsctiption
   
    var description: String {
        switch self {
//        case .HelpWithSubsctiption: return "Help With Subscription"
        case .Terms: return "Terms of Use"
        case .Privacy: return "Privacy Policy"
        case .ContactUs: return "Contact us"
        }
    }
    
    var image: UIImage {
        switch self {
//        case .HelpWithSubsctiption: return UIImage(named: "help") ?? UIImage()
        case .Terms: return UIImage.instantinate(from: .termsImg)
        case .Privacy: return UIImage.instantinate(from: .privacyImg)
        case .ContactUs: return UIImage.instantinate(from: .contactImg)
        }
    }

}
