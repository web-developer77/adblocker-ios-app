import Foundation
import StoreKit

extension SKProduct {
    
    var myLocalizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }

}

extension SKProduct {
    
    var durationPeriod: String {
        switch subscriptionPeriod?.unit {
        case .day:
            return "Day"
        case .week:
            return "Week"
        case .month:
            return "3 Month"
        case .year:
            return "Year"
        case .none:
            return ""
        case .some(_): return ""
        }
    }
    
    var introductoryPeriod: String {
        switch introductoryPrice?.subscriptionPeriod.unit.rawValue {
        case 0:
            return "Day"
        case 1:
            return "Week"
        case 2:
            return "Month"
        case 3:
            return "Year"
        default: return ""
        }
    }
}
