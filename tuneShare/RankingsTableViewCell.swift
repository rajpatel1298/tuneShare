//
//  RankingsTableViewCell.swift
//  tuneShare
//
//  Created by Raj Patel on 7/12/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit

class RankingsTableViewCell: UITableViewCell {
    
    @IBOutlet var genreImageView: UIImageView!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var fourthLabel: UILabel!
    @IBOutlet var fifthLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
