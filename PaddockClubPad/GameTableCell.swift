//
//  GameTableCell.swift
//  PaddockClubPad
//
//  Created by Zel Marko on 05/02/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

class GameTableCell: UITableViewCell {

    @IBOutlet weak var guestName: UILabel!
    @IBOutlet var driverLabels: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
