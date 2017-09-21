//
//  ItemTableViewCell.swift
//  Namics
//
//  Created by Administrator on 21.09.17.
//  Copyright © 2017 Namics. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var item: Item? {
        didSet {
            if let item = item {
                nameLabel.text = item.name
                priceLabel.text = item.formattedPrice()
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped() {
        guard var item = item else { return }
        
        item.quantity += 1
    }
    
    @IBAction func removeButtonTapped() {
        guard var item = item else { return }
        
        if item.quantity > 0 {
            item.quantity -= 1
        }
    }
    
}
