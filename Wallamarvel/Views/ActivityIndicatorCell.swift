//
//  ActivityIndicatorCell.swift
//  Wallamarvel
//
//  Created by Carlos Núñez Aguilera on 20/2/16.
//  Copyright © 2016 Qualoo Apps. All rights reserved.
//

import UIKit

class ActivityIndicatorCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicatorView.startAnimating()
    }

}
