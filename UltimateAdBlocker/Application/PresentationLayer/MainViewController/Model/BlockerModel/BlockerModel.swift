
import UIKit



struct BlockerModel {
    
    let title: String
    let subTitle: String
    let imageName: String
    let key: String
    let bundle: String
    
}

//MARK: - Default
extension BlockerModel {
    static let defaultBlockers = [
        BlockerModel(title: "Porn Blocker", subTitle: "Blocks adult content", imageName: "pornImage", key: SharedUserDeafults.Keys.pornBlockerState, bundle: AppConstants.pornBlokerBundle),
        BlockerModel(title: "Ad Blocker", subTitle: "Blocks annoying ads", imageName: "adsImage", key: SharedUserDeafults.Keys.adsBlockerState, bundle: AppConstants.adsBlockerBundle),
        BlockerModel(title: "Tracking Blocker", subTitle: "Don't let track you", imageName: "trackImage", key: SharedUserDeafults.Keys.trackBlockerState, bundle: AppConstants.trackBlockerBundle),
        BlockerModel(title: "Malware Blocker", subTitle: "Protect yourself", imageName: "malwareImage", key: SharedUserDeafults.Keys.malwareBlockerState, bundle: AppConstants.malwareBlockerBundle),
    ]
}
