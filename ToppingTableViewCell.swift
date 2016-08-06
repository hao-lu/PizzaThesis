//
//  ToppingTableViewCell.swift
//  PizzaThesis
//
//  Created by Hao Lu on 8/4/16.
//  Copyright © 2016 Hao Lu. All rights reserved.
//

import UIKit

class ToppingTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var toppingLabel: UILabel!
    @IBOutlet weak var toppingImage: UIImageView!
    @IBOutlet weak var toppingAmount: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
