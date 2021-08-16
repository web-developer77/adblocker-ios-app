
import UIKit

enum SettingsModel: Int, CustomStringConvertible, CaseIterable {
    

   
    case Terms
    case Privacy
    case ContactUs
    case HelpWithSubsctiption
   
    var description: String {
        switch self {
        case .HelpWithSubsctiption: return "Help With Subscription"
        case .Terms: return "Terms of Use"
        case .Privacy: return "Privacy Policy"
        case .ContactUs: return "Contact Us"
        }
    }
    
    var image: UIImage {
        switch self {
        case .HelpWithSubsctiption: return UIImage(named: "help") ?? UIImage()
        case .Terms: return UIImage(named: "terms") ?? UIImage()
        case .Privacy: return UIImage(named: "privacy") ?? UIImage()
        case .ContactUs: return UIImage(named: "contact") ?? UIImage()
        }
    }

}
