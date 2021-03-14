//
//  NetworkServiceRoute.swift
//  iMediaCodingChanlenge
//
//  Created by Brahim ELMSSILHA on 3/13/21.
//

import Foundation

enum NetworkServiceRoute: String {
    case categories = "categories"
    case posts = "posts?page=1"
}

extension NetworkServiceRoute {
    
    static var paramKey: String { "$param" }
    
    func makeUrl(domaine name: String) -> URLComponents? {
        URLComponents(string: name + "/" + self.rawValue)
    }
}
