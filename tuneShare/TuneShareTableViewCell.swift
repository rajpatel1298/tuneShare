//
//  TuneShareTableViewCell.swift
//  tuneShare
//
//  Created by Raj Patel on 6/29/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit

class TuneShareTableViewCell: UITableViewCell {
    
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var albumLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
