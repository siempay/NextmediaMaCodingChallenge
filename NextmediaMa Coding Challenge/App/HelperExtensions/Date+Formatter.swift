//
//  Date+Formatter.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation


extension Date {
    
    func toString() -> String? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = .init(identifier: "Ar")
        return formatter.string(from: self)
    }
}


extension String {
    
    func toDate() -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = .init(identifier: "Ar")
        return formatter.date(from: self)
    }
}

