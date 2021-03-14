//
//  ShowCategory.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation


struct ShowCategory {
    
    let id: Int64
    let title: String?
    
    init(_ item: CategoryDAO.DataCategory) {
        
        self.id = item.id
        self.title = item.title
    }
}
