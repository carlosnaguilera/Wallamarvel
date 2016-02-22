//
//  CharactersSearchResultsViewController.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 21/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import Alamofire

class CharactersSearchResultsViewController: BaseCharacterListViewController, UISearchBarDelegate {
    
    var searchString: String?
    var currentRequest: Request?
    /// Reference to the "owner" of this viewcontroller
    var charactersListViewController: CharactersViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The list and search results controllers will have the same delegate
        delegate = charactersListViewController?.delegate
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Hide placeholder view 
        self.placeholderView.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Overriden methods
    override func populateCharacters() {
        if let text = searchString {
            currentRequest = populateCharactersWithRequest(Router.CharactersStartingWithString(text, page: self.currentPage))
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
        currentRequest?.cancel()
        reset()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // If the user clears the text we need to reset the controller
        if searchText == "" && searchText != searchString {
            currentRequest?.cancel()
            reset()
        }
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        // We don't let to do a new search until the current one has finished
        return !populatingCharacters
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        // We don't let to do a new search until the current one has finished
        return !populatingCharacters
    }
    
    // MARK: TableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCharacter = characters[indexPath.row] as! Character
        delegate?.characterSelected(selectedCharacter)
        if let detailViewController = self.delegate as? CharacterDetailViewController {
            charactersListViewController?.splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
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
