//
//  TweetFeedCell.swift
//  PaddockClubPad
//
//  Created by Zel Marko on 22/12/14.
//  Copyright (c) 2014 Zel Marko. All rights reserved.
//

import UIKit

class TweetFeedCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mediaImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
  
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
