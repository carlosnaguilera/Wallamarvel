//
//  CharactersViewController.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 18/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import UIKit

 /// ViewController to display a list of Marvel characters

class CharactersViewController: BaseCharacterListViewController, UISearchBarDelegate {
    
    /// search results view controller.
    var searchResultsViewController: CharactersSearchResultsViewController!
    
    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Configure search results controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        searchResultsViewController = storyboard.instantiateViewControllerWithIdentifier("characterSearchResultsViewController") as! CharactersSearchResultsViewController
        searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
        
        // Texts
        self.title = NSLocalizedString("CharactersViewControllerTitle", comment: "Characters list title")
        self.noDataLabel.text = NSLocalizedString("NoDataLabel", comment: "No data label text")
        self.retryButton.setTitle(NSLocalizedString("RetryButton", comment: "Retry button"), forState: UIControlState.Normal)
        
        populateCharacters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        NSLog("Search")
        searchBar.resignFirstResponder()
    }

    
    // MARK: Buttons
    
    @IBAction func retryButtonTouched(sender: AnyObject) {
        populateCharacters()
    }
}
