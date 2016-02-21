//
//  Router.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 20/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import Alamofire
import CryptoSwift

 /// Router enum to get the url requests needed

enum Router: URLRequestConvertible {
    static let baseURLString = "https://gateway.marvel.com/v1/public"
    static let publicKey = "4076db26365bbdfe86886d00d50bb9d0"
    static let privateKey = "7ea204c124978d93f7a0723e24400622cb821aa3"
    static let perPage = 30
    
    /**
     *  URL to get Page page of characters api
     *
     *  @param Int the page to retrieved
     *
     *  @return URL to get Page page of characters api
     */
    
    case CharactersPage(Int)
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: AnyObject]) = {
            let ts = NSDate().timeIntervalSinceReferenceDate.description
            let hash = "\(ts)\(Router.privateKey)\(Router.publicKey)".md5()
            switch self {
            case .CharactersPage(let page) where page > 1:
                return("/characters", ["apikey": Router.publicKey, "ts": ts, "hash":hash, "offset": Router.perPage*(page-1), "limit":Router.perPage])
            case .CharactersPage(_):
                return ("/characters", ["apikey": Router.publicKey, "ts": ts, "hash":hash, "limit":Router.perPage])
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
    
}
