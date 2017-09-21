//
//  Item.swift
//  Namics
//
//  Created by Administrator on 21.09.17.
//  Copyright © 2017 Namics. All rights reserved.
//

struct Item {

    // MARK: - Properties
    var name: String?
    var price: Double?
    var unit: String?
    var quantity = 0
    
    // MARK: - Initializer
    init(name: String, price: Double, unit: String) {
        self.name = name
        self.price = price
        self.unit = unit
    }
    
    // MARK: - Public API
    func formattedPrice() -> String {
        guard let price = price, let unit = unit else { return "" }
        
        return "$\(price) per \(unit)"
    }
    
}
