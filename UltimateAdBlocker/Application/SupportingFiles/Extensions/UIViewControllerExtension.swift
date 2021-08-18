//
//  UIViewControllerExtension.swift
//  UltimateAdBlocker
//
//  Created by Aira on 16.08.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum StoryboardName: String {
        case loading = "Loading"
        case privacy = "Privacy"
    }
    
    class func instantiate(from storyboard: StoryboardName) -> Self {
        let viewControllerIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self else {
            preconditionFailure("Unable to instantiate view controller with identifier \(viewControllerIdentifier) as type \(type(of: self))")
        }
        return viewController
    }
}
