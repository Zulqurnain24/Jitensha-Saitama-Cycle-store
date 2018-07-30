//
//  PaymentCell.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 16/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import UIKit

class PaymentTableviewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDateCreated: UILabel!
    @IBOutlet weak var labelCardNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
