//
//  DataManager.swift
//  Namics
//
//  Created by Administrator on 21.09.17.
//  Copyright © 2017 Namics. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    // MARK: - Properties
    static let shared = DataManager()
    private override init() {}
    var goods = [
        Item(name: "Peas", price: 0.95, unit: "bag"),
        Item(name: "Eggs", price: 2.10, unit: "dozen"),
        Item(name: "Milk", price: 1.30, unit: "bottle"),
        Item(name: "Beans", price: 0.73, unit: "can")
    ]
    var rates = JSON()
    var rate = "USDUSD"
    
    // MARK: - Public API
    func total() -> String {
        return "0.0"
    }
    
}
