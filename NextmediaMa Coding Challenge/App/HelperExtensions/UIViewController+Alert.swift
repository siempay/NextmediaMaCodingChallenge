//
//  UIViewController+Alert.swift
//  NextmediaMa Coding Challenge
//
//  Created by Brahim ELMSSILHA on 3/13/21.
//

import UIKit

extension UIViewController {
    
    
    func alertAttention(error: Error) {
        
        alertAttention(message: "\(error)")
    }
    
    func alertAttention(message: String) {
        
        let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// this add a child controller to the view of another controller
    func addAsChildViewController(type controller: UIViewController, attached toView: UIView) {
        
        // Add Child View Controller
        addChild(controller)
        
        // Add Child View as Subview
        toView.addSubview(controller.view)
        
        // Configure Child View
        controller.view.frame = toView.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        controller.didMove(toParent: self)
        
    }
}
