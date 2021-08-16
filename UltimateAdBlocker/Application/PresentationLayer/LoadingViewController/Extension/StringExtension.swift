//
//  StringExtension.swift
//  FVBlocker
//
//  Created by Macintosh on 05.11.2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import Foundation

extension Date {
    
    func string() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: self)
    }
    
    func daysFromToday() -> Int {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
    }
    
}

extension String {
    
    func date() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from: self) ?? Date()
    }
    
}

