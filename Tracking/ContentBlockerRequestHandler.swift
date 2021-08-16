//
//  ContentBlockerRequestHandler.swift
//  Tracking
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        let sharedUserDeafults = UserDefaults(suiteName: SharedUserDeafults.suiteName)
        
        guard let trackBlockerOn = sharedUserDeafults?.bool(forKey: SharedUserDeafults.Keys.trackBlockerState) else { return }
        
        if trackBlockerOn {
            let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "trackList", withExtension: "json"))!
            
            let item = NSExtensionItem()
            item.attachments = [attachment]
            
            context.completeRequest(returningItems: [item], completionHandler: nil)
        } else {
            let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
            
            let item = NSExtensionItem()
            item.attachments = [attachment]
            
            context.completeRequest(returningItems: [item], completionHandler: nil)
        }
    }
}
