//
//  CollorSetupViewController.swift
//  ColorizedApp
//
//  Created by Andry Pro on 16.02.2020.
//  Copyright © 2020 Andry Pro. All rights reserved.
//

import UIKit

class ColorSetupViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: - Public properties
    var delegate: ColorSetupViewControllerDelegate!
    var color: UIColor!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)
        
        setValueFromViewColor(color)
    }
    
    // MARK: - IBActions
    @IBAction func slidrAction(_ sender: Any) {
        setRGB()
        setLabels()
        setTextFields()
    }
    
    @IBAction func dineButtonPressed(_ sender: Any) {
        delegate.setupViewColor(mainView.backgroundColor!)
        dismiss(animated: true)
    }
    
    // MARK: - Public methods
    func setRGB() {
        mainView.backgroundColor = UIColor(red: CGFloat(redSlider!.value), green: CGFloat(greenSlider!.value), blue: CGFloat(blueSlider!.value), alpha: 1)
    }
    
    // MARK: - Private Methods
    private func setLabels() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setTextFields() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setValueFromViewColor(_ color: UIColor) {
        guard let components = color.cgColor.components else { return }
        print(components)
        redSlider.value = Float(components[0])
        greenSlider.value = Float(components[1])
        blueSlider.value = Float(components[2]) // Понимаю что это костыль, но другого способа не нашел7
        setRGB()
        setLabels()
        setTextFields()
    }
}

// MARK: - Work with keyboard
extension ColorSetupViewController {
    private func addDoneButtonTo(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    @objc private func didTapDone() {
        self.view.endEditing(true)
    }
    
    func allertController() {
        let alert = UIAlertController(title: "Wrong format!",
                                      message: "Please enter a number in the range from 0 to 1",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
