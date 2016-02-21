//
//  MarvelStore.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 19/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import Alamofire
import SwiftyJSON

 /// Store class to create Marvel model classes

class MarvelStore {
    /// Singleton of MarvelStore
    static let sharedInstance = MarvelStore()
    
    /**
     Creates an array of characters parsing the received response. Return nil if response doesn't have a valid value or if the response doesn't contain any character
     
     - parameter response: response from the server
     
     - returns: an array of characters parsing the received response
     */
    func getCharactersFromResponse(response: (Response<AnyObject, NSError>)) -> [Character]? {
        
        if let value = response.result.value {
            let json = JSON(value)
            let characterDictionaries = json["data"]["results"].arrayValue
            
            if characterDictionaries.count == 0 {
                return nil
            }
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
