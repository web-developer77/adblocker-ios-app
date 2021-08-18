
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
        BlockerModel(title: "Stop ads", subTitle: "Disable useless ads", imageName: "ic_stop_ad", key: SharedUserDeafults.Keys.adsBlockerState, bundle: AppConstants.adsBlockerBundle),
        BlockerModel(title: "Block Porn", subTitle: "Make browsing safe for kids", imageName: "ic_block_porn", key: SharedUserDeafults.Keys.pornBlockerState, bundle: AppConstants.pornBlokerBundle),
        BlockerModel(title: "Block Viruses", subTitle: "Disable useless ads", imageName: "ic_block_virus", key: SharedUserDeafults.Keys.malwareBlockerState, bundle: AppConstants.malwareBlockerBundle),
        BlockerModel(title: "Stop Tracking", subTitle: "Make websites respeect privacy", imageName: "ic_stop_tracking", key: SharedUserDeafults.Keys.trackBlockerState, bundle: AppConstants.trackBlockerBundle),
    ]
}
