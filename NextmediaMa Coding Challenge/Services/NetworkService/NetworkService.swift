//
//  NetworkService.swift
//  iMediaCodingChanlenge
//
//  Created by Brahim ELMSSILHA on 3/13/21.
//

import Foundation
import Alamofire

/// Make calls to API using `NetworkServiceRoute` list of supported routes
///
/// We can configure this service to use differente domaines (prod, test, recette).
///
/// We can add authentication and more capabilities like post request, uploading, downloading data etc...
///
class NetworkService {
    
    typealias Completion = (NetworkResult) -> ()
    
    enum NetworkResult {
        case success(Any)
        case Error(Error)
    }
    
    struct NetworkRequest {
        
        var route: URLComponents?
        let method: Alamofire.HTTPMethod
        var query: (key:String, val: String)?
        
        init(method: Alamofire.HTTPMethod, _ route: URLComponents?) {
            self.method = method
            self.route = route
        }
    }
    
    // Singlton instance
    static var shared: NetworkService {
        if instance == nil {
            instance = .init()
        }
        
        instance.request = nil
        return instance
    }
    private static var instance: NetworkService!
    
    /// Main domaine
    let domaineName: String
    
    var request: NetworkRequest?
    
    private init() {
        domaineName = "http://soltana.ma/wp-json/wp/v2"
    }
    
    /// Create new Request by route and method
    ///
    /// This way we can build the request as needed by adding more functions
    ///
    func createRequest(_ method: Alamofire.HTTPMethod, _ route: NetworkServiceRoute) -> NetworkService {
        
        request = NetworkRequest(method: method, route.makeUrl(domaine: self.domaineName))
        return self
    }
    
    func setupQuery(_ query: (key: String, val: String)...) -> NetworkService {
        
        request?.route?.queryItems = query.map({
            URLQueryItem(name: $0.key, value: $0.val)
        })
        return self
    }
    
    /// Run the request and get the response
    func makeCall(_ completion: @escaping NetworkService.Completion) {
        
        guard let _request = request else {
            completion(.Error("Network request is nil"))
            return
        }
        
        guard let url = _request.route else {
            completion(.Error("URL not valide"))
            return
        }
        
        print(url.path)

        AF.request(url, method: _request.method)
            .responseJSON { data in
                
                switch data.result {
                case .success(let val):
                    completion(.success(val))
                    break
                case .failure(let error):
                    completion(.Error(error))
                    break
                }
            }
    }
}
