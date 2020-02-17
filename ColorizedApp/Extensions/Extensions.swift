//
//  Extensions.swift
//  ColorizedApp
//
//  Created by Andry Pro on 17.02.2020.
//  Copyright © 2020 Andry Pro. All rights reserved.
//

import UIKit

// MARK: - UI TextField Delegate methods
extension ColorSetupViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.first == "." {
            textField.text = "0."
        }
        if text == "0" {
            textField.text = "0."
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redTextField:
            dataTranmision(from: redTextField, to: redSlider)
        case greenTextField:
            dataTranmision(from: greenTextField, to: greenSlider)
        case blueTextField:
            dataTranmision(from: blueTextField, to: blueSlider)
        default:
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dataTranmision(from textField: UITextField, to slider: UISlider) {
        guard let textInput = textField.text else { return }
        guard let value = Float(textInput) else {
            allertController()
            return
        }
        if value >= 0 && value <= 1 {
            slider.value = value
            setRGB()
        } else {
            allertController()
        }
    }
}


