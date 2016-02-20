//
//  CharactersViewController.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 18/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import UIKit
import Alamofire

 /// ViewController to display a list of Marvel characters

class CharactersViewController: UITableViewController {
    
    var characters = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.title = NSLocalizedString("CharactersViewControllerTitle", comment: "Characters list title")
        
        request(Router.CharactersPage(0))
            .validate()
            .responseJSON { response in
            switch response.result {
            case .Success:
                if let newCharacters = MarvelStore.sharedInstance.getCharactersFromResponse(response) {
                    self.characters.appendContentsOf(newCharacters)
                    self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            case .Failure(let error):
                print(error)
            }

        }
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
