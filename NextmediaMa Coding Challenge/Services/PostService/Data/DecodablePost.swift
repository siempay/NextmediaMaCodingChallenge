//
//  DecodablePost.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation


struct DecodablePost: Codable {
    
    let id: Int
    let title: RenderedText
    let content: RenderedText
    let date: String?
    let categories: [Int]
    
    struct RenderedText: Codable {
        let rendered: String
    }
}
