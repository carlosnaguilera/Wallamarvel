//
//  CharacterTests.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 18/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import XCTest

class CharacterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCharacterInitialization() {
        
        // Success case
        let potentialCharacter = Character(id: 1009144, name: "A.I.M", description: "AIM is a terrorist organization bent on destroying the world.", imagePath: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", imageExtension: "jpg")
        XCTAssertNotNil(potentialCharacter)
        
        // Failure case
        let noCharacter = Character(id: 1009144, name: "", description: "AIM is a terrorist organization bent on destroying the world.", imagePath: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", imageExtension: "jpg")
        XCTAssertNil(noCharacter, "Empty name is invalid")
    }
    
    func testGetImageURLForVariant() {
        
        let character = Character(id: 1009144, name: "A.I.M", description: "AIM is a terrorist organization bent on destroying the world.", imagePath: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", imageExtension: "jpg")
        XCTAssertNotNil(character?.getImageURLForVariant(ImageVariant.LandscapeIncredible), "getImageURLForVariant should return a valid NSURL")
    }
}
