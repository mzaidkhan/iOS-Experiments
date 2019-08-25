//
//  ViewController.swift
//  BMI-Calculator
//
//  Created by Mohammed Zaid Khan on 14.08.19.
//  Copyright © 2019 Mohammed Zaid Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var bmiField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateBMI(_ sender: Any) {
        let weight = Double(weightField.text!)!
        let height = Double(heightField.text!)!
        
        let bmi = weight / (height * height)
        bmiField.text = "Your BMI is \(String(format: "%.1f", bmi))"
    }
    
}

