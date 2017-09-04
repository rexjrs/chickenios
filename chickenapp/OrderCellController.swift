//
//  OrderCellController.swift
//  chickenapp
//
//  Created by Thomas on 8/31/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import UIKit

class OrderCellController: UITableViewCell {

    @IBOutlet weak var pvContainer: UIView!
    @IBOutlet weak var orderPV: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pvContainer.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
