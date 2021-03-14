//
//  ShowCategoryDelegate.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation

protocol ShowCategoryDelegate {
    
    func didLoadCategories()
    
    /// On select category from menu: show list of posts
    /// of the selected category
    /// - parameter category: optional, nil means show all
    func didSelectCategory(category: ShowCategory?)
}
