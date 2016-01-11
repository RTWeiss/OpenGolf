//
//  RoundTableViewCell.swift
//  OpenGolf
//
//  Created by Christopher Cobar on 1/9/16.
//  Copyright © 2016 ChristopherCobar. All rights reserved.
//

import UIKit

class RoundTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var golfCoursePlayedLabel: UILabel!
    @IBOutlet weak var datePlayedLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var puttsPerHoleLabel: UILabel!
    @IBOutlet weak var fairwayAccuracyLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
