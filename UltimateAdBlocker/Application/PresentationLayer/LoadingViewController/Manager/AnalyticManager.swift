//
//  AnalyticManager.swift
//  RemoveAds
//
//  Created by Macintosh on 11.11.2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

class AnalyticManager {
    
    static var urlStr = "\(AppConstants.baseURL)/track"
    
    static func logInstall(params: [String: String], completion: @escaping ((_ model: ResponsePushModel?) -> Void)) {
        let session = URLSession.shared
        let url = URL(string: urlStr)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var json = [String: String]()
        json["event"] = "install"
        json["udid"] = UIDevice.current.identifierForVendor?.uuidString ?? "" + (Locale.preferredLanguages.first ?? "")
        
        for (key, value) in params {
            json[key] = value
        }

        print(json)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) else { return }
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
                        
            let bs64String = (String(data: data, encoding: .utf8) ?? "").components(separatedBy: .whitespacesAndNewlines).joined()

            guard let decodedData = Data(base64Encoded: bs64String) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                let model = try? JSONDecoder().decode(ResponsePushModel.self, from: decodedData)
                completion(model)
            }
        }
        
        task.resume()
    }
    
    static func logPurchase(id: String) {
        let session = URLSession.shared
        let url = URL(string: urlStr)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var json = [String: String]()
        json["event"] = "purchase"
        json["udid"] = UIDevice.current.identifierForVendor?.uuidString ?? "" + (Locale.preferredLanguages.first ?? "")
        json["payout"] = id
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) else { return }
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in }
        
        task.resume()
    }
    
}
