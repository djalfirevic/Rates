//
//  PickerTextField.swift
//  Namics
//
//  Created by Administrator on 21.09.17.
//  Copyright © 2017 Namics. All rights reserved.
//

import UIKit

enum Mode: Int {
    case picker, date
}

protocol PickerTextFieldDelegate: class {
    func pickerTextField(_ textField: PickerTextField, didSelectOption option: String)
}

class PickerTextField: UITextField {

    // MARK: - Properties
    var options = [String]() {
        didSet {
            selectedOption = options.first
            selectedIndex = 0
        }
    }
    var selectedOption: String?
    var selectedIndex: Int?
    var mode = Mode.picker {
        didSet {
            if mode == .picker {
                setup()
            } else {
                setupDatePicker()
            }
        }
    }
    var date: Date! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            selectedOption = dateFormatter.string(from: date)
        }
    }
    weak var pickerDelegate: PickerTextFieldDelegate?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    // MARK: - Actions
    @objc func pickerDone() {
        guard let option = selectedOption else {
            return
        }

        text = selectedOption

        if let pickerDelegate = pickerDelegate {
            pickerDelegate.pickerTextField(self, didSelectOption: option)
        }

        endEditing(true)
    }

    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        text = dateFormatter.string(from: date)
        selectedOption = text
        date = sender.date

        if let pickerDelegate = pickerDelegate {
            pickerDelegate.pickerTextField(self, didSelectOption: dateFormatter.string(from: date))
        }
    }

    // MARK: - Private API
    fileprivate func setup() {
        let screen = UIScreen.main

        let pickerView = UIPickerView()
        pickerView.frame = CGRect(x: 0, y: 0, width: screen.bounds.size.width, height: pickerView.frame.size.height)
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
        pickerView.tintColor = UIColor.white
        inputView = pickerView

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screen.bounds.size.width, height: 44))
        toolbar.isTranslucent = false
        toolbar.tintColor = UIColor.darkGray
        toolbar.barTintColor = UIColor.white

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerDone))
        toolbar.items = [flexibleSpace, doneButton]
        inputAccessoryView = toolbar

        if let text = selectedOption {
            var index = Int(INT_MAX)

            if options.contains(text) {
                index = options.index(of: text)!
            }

            if index != Int(INT_MAX) {
                pickerView.selectRow(index, inComponent: 0, animated: true)
            }
        }
    }

    fileprivate func setupDatePicker() {
        let screen = UIScreen.main

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor.white
        datePicker.tintColor = UIColor.darkGray
        datePicker.date = date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        inputView  = datePicker

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screen.bounds.size.width, height: 44))
        toolbar.isTranslucent = false
        toolbar.tintColor = UIColor.darkGray
        toolbar.barTintColor = UIColor.white

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerDone))
        toolbar.items = [flexibleSpace, doneButton]
        inputAccessoryView = toolbar
    }

}

extension PickerTextField: UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let option = options[row]
        let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14.0), NSAttributedStringKey.foregroundColor:UIColor.black]
        
        return NSAttributedString(string: option, attributes: attributes)
    }

    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let option = options[row]

        text = option
        selectedOption = option
        selectedIndex = row
    }
    
}
