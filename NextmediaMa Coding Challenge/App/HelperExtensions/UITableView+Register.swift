//
//  UITableView+Register.swift
//  NextmediaMa Coding Challenge
//
//  Created by Brahim ELMSSILHA on 3/13/21.
//

import UIKit


extension UITableView {
    
    
    /// Register class with its nib to the collcetionView
    func registerWithNib<T: UITableViewCell>(_ cell: T.Type, for identifier: String) {
        
        self.register(cell, forCellReuseIdentifier: identifier)
        let nib = UINib(nibName: String.init(describing: cell), bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}

extension UICollectionView {
    
    
    /// Register class with its nib to the collcetionView
    func registerWithNib<T: UICollectionViewCell>(_ cell: T.Type, for identifier: String) {
        
        self.register(cell, forCellWithReuseIdentifier: identifier)
        let nib = UINib(nibName: String.init(describing: cell), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
