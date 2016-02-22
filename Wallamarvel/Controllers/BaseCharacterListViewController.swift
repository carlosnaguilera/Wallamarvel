//
//  BaseCharacterListViewController.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 21/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import Alamofire

protocol CharacterSelectionDelegate: class {
    
    /**
     Tells the delegate that a character was selected
     
     - parameter newCharacter: selected character
     */
    func characterSelected(newCharacter: Character)
}

class BaseCharacterListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // We use an ordered set to avoid having duplicates when paginating
    var characters = NSMutableOrderedSet()
    var populatingCharacters = false
    var currentPage = 1
    var morePages = false
    
    weak var delegate: CharacterSelectionDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if populatingCharacters {
            return self.characters.count + 1
        }
        else {
            return self.characters.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.row == characters.count {
            cell = tableView.dequeueReusableCellWithIdentifier("activityIndicatorCell", forIndexPath: indexPath)
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("characterCell", forIndexPath: indexPath)
            let character = self.characters[indexPath.row]
            cell.textLabel?.text = character.name;
        }
        return cell
    }
    
    // MARK: ScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height && morePages{
            populateCharacters()
        }
    }
    
    // MARK: Helper methods
    
    /**
    Gets the characters from the server and updates the UI using the received urlRequest
    
    - parameter urlRequest: request to get the needed characters
    */
    func populateCharactersWithRequest(urlRequest:  URLRequestConvertible) -> Request? {
        if populatingCharacters {
            return nil
        }
        populatingCharacters = true
        // Hide placeholder if needed
        if placeholderView.alpha != 0 {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.placeholderView.alpha = 0.0
            })
        }
        let lastItem = self.characters.count
        
        let loaderIndexPath = NSIndexPath(forRow: lastItem, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([loaderIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        self.tableView .scrollToRowAtIndexPath(loaderIndexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        
        return request(urlRequest)
            .validate()
            .responseJSON { response in
                var shouldShowPlaceholder = true
                var placeholderText = NSLocalizedString("NoResults", comment: "")
                switch response.result {
                case .Success:
                    if let parsedCharactersResponse = MarvelStore.sharedInstance.getCharactersFromResponse(response) {
                        self.characters.addObjectsFromArray(parsedCharactersResponse.newCharacters)
                        self.morePages = parsedCharactersResponse.moreCharacters
                        self.currentPage++
                    }
                case .Failure(let error):
                    NSLog(error.description)
                    // Check if we need to show the placeholder. If it has been cancelled is not an error
                    if error.code == NSURLErrorCancelled {
                        shouldShowPlaceholder = false
                    }
                    placeholderText = NSLocalizedString("NoDataLabel", comment: "")
                }
                // Refresh UI
                self.tableView.beginUpdates()
                // remove activity indicator cell
                self.tableView.deleteRowsAtIndexPaths([loaderIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                // add new cells if necessary
                if (lastItem != self.characters.count) {
                    let indexPaths = (lastItem..<self.characters.count).map { NSIndexPath(forRow: $0, inSection: 0) }
                    self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
                }
                self.populatingCharacters = false
                self.tableView.endUpdates()
                
                // Show placeholder if needed
                if self.characters.count == 0 && shouldShowPlaceholder {
                    self.noDataLabel.text = placeholderText
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.placeholderView.alpha = 1.0
                    })
                }
        }
    }
    
    /**
     Gets the needed characters from the server and updates the UI. This method must be implemented by subclasses
     */
    func populateCharacters() {
        // Method to be implemented by subclasses
    }
}
