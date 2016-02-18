//
//  CharactersViewController.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 18/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import UIKit

 /// ViewController to display a list of Marvel characters

class CharactersViewController: UITableViewController {
    
    var characters = [Character]()
    
    // Method to delete
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.characters.append(Character(id: 1009144, name: "A.I.M.", description: "AIM is a terrorist organization bent on destroying the world.",imagePath: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", imageExtension: "jpg")!)
        self.characters.append(Character(id: 1010699, name: "Aaron Stack", description: "",imagePath: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", imageExtension: "jpg")!)
        self.characters.append(Character(id: 1009146, name: "Abomination (Emil Blonsky)", description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.",imagePath: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04", imageExtension: "jpg")!)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.title = NSLocalizedString("CharactersViewControllerTitle", comment: "Characters list title")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("characterCell", forIndexPath: indexPath)
        
        let character = self.characters[indexPath.row]
        cell.textLabel?.text = character.name;
        return cell
    }
}
