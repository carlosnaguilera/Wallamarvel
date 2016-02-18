//
//  Character.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 17/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import Foundation

/**
 
 ImageSizes and ratios
 
 
 - PortraitSmall:       50x75px
 
 - PortraitMedium:      100x150px
 
 - PortraitXlarge:      150x225px
 
 - PortraitFantastic:   168x225px
 
 - PortraitUncanny:     300x450px
 
 - PortratiIncredible:  216x324px
 
 - StandardSmall:       65x45px
 
 - StandardMedium:      100x100px
 
 - StandardLarge:       140x140px
 
 - StandardXlarge:      200x200px
 
 - StandardFantastic:   250x250px
 
 - StandardAmazing:     180x180px
 
 - LandscapeSmall:      120x90px
 
 - LandscapeMedium:     175x130px
 
 - LandscapeLarge:      190x140px
 
 - LandscapeXlarge:     270x200px
 
 - LandscapeAmazing:    250x156px
 
 - LandscapeIncredible: 426x261px
 
 - Detail:              full image, constrained to 500px wide
 
 - FullSizeImage:       no variant descriptor
 
 */

enum ImageVariant {
    // Portrait variants
    case PortraitSmall, PortraitMedium, PortraitXlarge, PortraitFantastic, PortraitUncanny, PortraitIncredible
    // Square variants
    case StandardSmall, StandardMedium, StandardLarge, StandardXlarge, StandardFantastic, StandardAmazing
    // Landscape variants
    case LandscapeSmall, LandscapeMedium, LandscapeLarge, LandscapeXlarge, LandscapeAmazing, LandscapeIncredible
    case Detail, FullSizeImage
    
    /**
     Returns the variant name to append to the path element
     
     - returns: variant name to append to the path element
     */
    func variantName() -> String {
        switch self {
        case .PortraitSmall:
            return "portrait_small"
        case .PortraitMedium:
            return "portrait_medium"
        case .PortraitXlarge:
            return "portrait_xlarge"
        case .PortraitFantastic:
            return "portrait_fantastic"
        case .PortraitUncanny:
            return "portrait_uncanny"
        case .PortraitIncredible:
            return "portrait_incredible"
        case .StandardSmall:
            return "standard_small"
        case .StandardMedium:
            return "standard_medium"
        case .StandardLarge:
            return "standard_large"
        case .StandardXlarge:
            return "standard_xlarge"
        case .StandardFantastic:
            return "standard_fantastic"
        case .StandardAmazing:
            return "standard_amazing"
        case .LandscapeSmall:
            return "landscape_small"
        case .LandscapeMedium:
            return "landscape_medium"
        case .LandscapeXlarge:
            return "landscape_xlarge"
        case .LandscapeLarge:
            return "landscape_large"
        case .LandscapeAmazing:
            return "landscape_amazing"
        case .LandscapeIncredible:
            return "landscape_incredible"
        case .Detail:
            return "detail"
        case .FullSizeImage:
            return "full-size-image"
        }
    }
}


 /// Model class to store information of a Marvel character

class Character {
    
    // MARK: Properties
    
    /// id of the character
    let id: Int
    /// name of the character
    let name: String
    /// description of the character
    let description: String?
    /// "path" element from the image representation. It's not complete. We have to build the final url from it
    let imagePath: String?
    /// file extension of the character image
    let imageExtension: String?
    
    // MARK: Initialization
    
    /**
    Designated initializer for a Character. If id or name are nil, it fails
    
    - parameter id:             character id
    - parameter name:           character name
    - parameter description:    character description
    - parameter imagePath:      "path" element from the image representation
    - parameter imageExtension: extension of the image file
    
    - returns: a new created Character class instance
    */
    init?(id: Int, name: String, description: String?, imagePath: String?, imageExtension: String?) {
        
        self.id = id
        self.name = name
        self.description = description
        self.imagePath = imagePath
        self.imageExtension = imageExtension
        
        if name.isEmpty {
            return nil
        }
        
    }
    
    // MARK: Helper methods

    /**
    Returns the specified imageVariant for the character. If the character has imagePath or imageExtension nil, returns nil
    
    - parameter imageVariant: the image variant to return
    
    - returns: imageVariant for the character. If the character has imagePath or imageExtension nil, returns nil
    */
    func getImageURLForVariant(imageVariant: ImageVariant) -> NSURL? {
        
        guard let imagePath = self.imagePath else {
            return nil
        }
        guard let imageExtension = self.imageExtension else {
            return nil
        }
        let imageURLString = "\(imagePath)/\(imageVariant.variantName())/\(imageExtension)"
        if let imageURL = NSURL(string: imageURLString) {
            return imageURL
        }
        else {
            return nil
        }
    }
}

