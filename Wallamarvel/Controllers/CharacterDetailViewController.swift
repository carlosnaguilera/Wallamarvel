//
//  CharacterDetailViewController.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 22/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import UIKit
import AlamofireImage

class CharacterDetailViewController: UIViewController, CharacterSelectionDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var character: Character? {
        didSet (newCharacter) {
            self.refreshUI()
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Helper methods
    
    func refreshUI() {
        // we use optional chaining even though the properties are implicitly-unwrapped optionals. It’s possible that we'll change character and trigger the method even before the view has loaded, so we need to be sure to check that the outlets are connected first.
        nameLabel?.text = character?.name
        descriptionLabel?.text = character?.detail
        if let URL = character?.getImageURLForVariant(ImageVariant.LandscapeIncredible) {
            if let placeholderImage = UIImage(named: "placeholder") {
                imageView?.af_setImageWithURL(URL, placeholderImage: placeholderImage)
            }
            else {
                imageView?.af_setImageWithURL(URL)
            }
        }
    }
    
    // MARK: CharacterSelectionDelegate
    
    func characterSelected(newCharacter: Character) {
        character = newCharacter
    }
}
