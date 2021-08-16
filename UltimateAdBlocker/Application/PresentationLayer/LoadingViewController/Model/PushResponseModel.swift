//
//  PushResponseModel.swift
//  FVBlocker
//
//  Created by Macintosh on 05.11.2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import Foundation

class ResponsePushModel: Codable {
    
    var end = ""
    var push = [PushModel]()
    
    enum CodingKeys: String, CodingKey {
        case push, end
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        end = try values.decodeIfPresent(String.self, forKey: .end) ?? ""
        push = try values.decodeIfPresent([PushModel].self, forKey: .push) ?? []
    }
    
}


class PushModel: Codable {
    
    var title = ""
    var text = ""
    var count = 0
    var startInterval = 0
    var timeInterval = 0
    
    enum CodingKeys: String, CodingKey {
        case title, text, count, startInterval, timeInterval
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        text = try values.decodeIfPresent(String.self, forKey: .text) ?? ""
        count = try values.decodeIfPresent(Int.self, forKey: .count) ?? 0
        startInterval = try values.decodeIfPresent(Int.self, forKey: .startInterval) ?? 0
        timeInterval = try values.decodeIfPresent(Int.self, forKey: .timeInterval) ?? 0
    }
    
}
