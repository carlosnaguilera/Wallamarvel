//
//  CharactersViewController.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 18/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import UIKit

 /// ViewController to display a list of Marvel characters

class CharactersViewController: BaseCharacterListViewController, UISplitViewControllerDelegate {
    
    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    @IBOutlet weak var retryButton: UIButton!
    
    private var collapseDetailViewController = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure search results controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchResultsViewController = storyboard.instantiateViewControllerWithIdentifier("characterSearchResultsViewController") as! CharactersSearchResultsViewController
        searchResultsViewController.charactersListViewController = self
        searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.delegate = searchResultsViewController
        
        definesPresentationContext = true
        
        // Texts
        self.title = NSLocalizedString("CharactersViewControllerTitle", comment: "Characters list title")
        self.retryButton.setTitle(NSLocalizedString("RetryButton", comment: "Retry button"), forState: UIControlState.Normal)
            
        populateCharacters()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        // viewDidAppear is not called on searchResultsController when poping
        if let searchResultsController = searchController?.searchResultsController as? CharactersSearchResultsViewController {
            if let indexPath = searchResultsController.tableView?.indexPathForSelectedRow {
                searchResultsController.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCharacter = characters[indexPath.row] as! Character
        delegate?.characterSelected(selectedCharacter)
        if let detailViewController = self.delegate as? CharacterDetailViewController {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        }
        collapseDetailViewController = false
    }

    
    // MARK: Buttons
    
    @IBAction func retryButtonTouched(sender: AnyObject) {
        populateCharacters()
    }
    
    // MARK: Overriden methods
    override func populateCharacters() {
        populateCharactersWithRequest(Router.CharactersPage(self.currentPage))
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return collapseDetailViewController
    }
}
