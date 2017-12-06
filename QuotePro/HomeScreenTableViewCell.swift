//
//  HomeScreenTableViewCell.swift
//  QuotePro
//
//  Created by Daniel Grosman on 2017-12-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

import UIKit

class HomeScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var newPhotoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
