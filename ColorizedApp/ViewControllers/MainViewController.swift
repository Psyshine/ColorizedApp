//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Andry Pro on 16.02.2020.
//  Copyright © 2020 Andry Pro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ColorSetupViewControllerDelegate {
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorSetupViewController = segue.destination as! ColorSetupViewController
        colorSetupViewController.delegate = self
        colorSetupViewController.color = view.backgroundColor
    }

    func setupViewColor(_ color: UIColor) {
        view.backgroundColor = color
       }
}

