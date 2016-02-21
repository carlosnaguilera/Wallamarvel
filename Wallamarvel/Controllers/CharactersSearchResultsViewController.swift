//
//  CharactersSearchResultsViewController.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 21/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import UIKit

class CharactersSearchResultsViewController: BaseCharacterListViewController, UISearchBarDelegate {
    
    var searchString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Overriden methods
    override func populateCharacters() {
        if let text = searchString {
            populateCharactersWithRequest(Router.CharactersStartingWithString(text, page: self.currentPage))
        }
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        reset()
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = NSCharacterSet.whitespaceCharacterSet()
        searchString = searchBar.text!.stringByTrimmingCharactersInSet(whitespaceCharacterSet)
        populateCharacters()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        reset()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // If the user clears the text we need to reset the controller
        if searchText == "" && searchText != searchString {
            reset()
        }
    }
    
    // MARK: Private helper methods
    private func reset() {
        currentPage = 1
        characters.removeAllObjects()
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
        searchString = ""
        morePages = false
    }


}
