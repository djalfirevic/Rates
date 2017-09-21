//
//  CheckoutViewController.swift
//  Namics
//
//  Created by Administrator on 21.09.17.
//  Copyright © 2017 Namics. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var currencyTextField: PickerTextField!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = DataManager.shared.total()
        
        // This should come from backend...
        currencyTextField.options = ["USDEUR", "USDUSD"]
        currencyTextField.pickerDelegate = self
    }
    
}

extension CheckoutViewController: PickerTextFieldDelegate {
    
    // MARK: - PickerTextFieldDelegate
    func pickerTextField(_ textField: PickerTextField, didSelectOption option: String) {
        
    }
    
}
