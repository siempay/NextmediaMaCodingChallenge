//
//  ShowPost.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation

struct ShowPost {
    
    let id: Int64
    let title: String?
    let content: String?
    
    let date: Date?
    var category: ShowCategory?
    
    init(_ item: PostDAO.DataPost) {
        
        self.id = item.id
        self.title = item.title
        self.content = item.content
        self.date = item.date
    }
    
}
