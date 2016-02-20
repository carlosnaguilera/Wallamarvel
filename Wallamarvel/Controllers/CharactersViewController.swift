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
    
    // We use an ordered set to avoid having duplicates when paginating
    var characters = NSMutableOrderedSet()
    var populatingCharacters = false
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.title = NSLocalizedString("CharactersViewControllerTitle", comment: "Characters list title")
        populateCharacters()
        
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
    
    // MARK: ScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height * 0.8 {
            populateCharacters()
        }
    }
    
    // MARK: Private methods
    
    private func populateCharacters() {
        if populatingCharacters {
            return
        }
        
        populatingCharacters = true
        
        request(Router.CharactersPage(self.currentPage))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let newCharacters = MarvelStore.sharedInstance.getCharactersFromResponse(response) {
                        let lastItem = self.characters.count
                        self.characters.addObjectsFromArray(newCharacters)
                        let indexPaths = (lastItem..<self.characters.count).map { NSIndexPath(forRow: $0, inSection: 0) }
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                        self.currentPage++
                    }
                case .Failure(let error):
                    NSLog(error.description)
                }
                self.populatingCharacters = false
        }
    }
}
