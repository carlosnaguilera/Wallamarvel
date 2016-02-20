//
//  MarvelStore.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 19/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import Alamofire
import CryptoSwift
import SwiftyJSON

enum Router: URLRequestConvertible {
    static let baseURLString = "https://gateway.marvel.com/v1/public"
    static let publicKey = "4076db26365bbdfe86886d00d50bb9d0"
    static let privateKey = "7ea204c124978d93f7a0723e24400622cb821aa3"
    static let perPage = 20
    
    
    case Characters(Int)
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: AnyObject]) = {
            let ts = NSDate().timeIntervalSinceReferenceDate.description
            let hash = "\(ts)\(Router.privateKey)\(Router.publicKey)".md5()
            switch self {
            case .Characters(let page) where page > 0:
                return("/characters", ["apikey": Router.publicKey, "ts": ts, "hash":hash, "offset": Router.perPage*page])
            case .Characters(_):
                return ("/characters", ["apikey": Router.publicKey, "ts": ts, "hash":hash])
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
    
}


class MarvelStore {
    static let sharedInstance = MarvelStore()
    
    func getCharactersFromResponse(response: (Response<AnyObject, NSError>)) -> [Character]? {
        
        if let value = response.result.value {
            let json = JSON(value)
            let characterDictionaries = json["data"]["results"].arrayValue
            
            var newCharacters = [Character]()
            
            for characterDictionary in characterDictionaries {
                // id and name are mandatory values to create a new character
                if let id = characterDictionary["id"].int, let name = characterDictionary["name"].string {
                    let description = characterDictionary["description"].stringValue
                    let imagePath = characterDictionary["thumbnail"]["path"].stringValue
                    let imageExtension = characterDictionary["thumbnail"]["extension"].stringValue
                    if let character = Character(id: id, name: name, description: description, imagePath: imagePath, imageExtension: imageExtension) {
                        newCharacters.append(character)
                    }
                }
            }
            return newCharacters
        }
        else {
            return nil
        }
    }
}
