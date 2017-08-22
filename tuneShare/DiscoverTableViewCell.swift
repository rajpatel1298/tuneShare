//
//  DiscoverTableViewCell.swift
//  tuneShare
//
//  Created by Raj Patel on 7/15/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {
    
    @IBOutlet var discoverImageView: UIImageView!
    @IBOutlet var discoverArtistLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
