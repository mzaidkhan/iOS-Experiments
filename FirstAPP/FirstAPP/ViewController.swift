//
//  ViewController.swift
//  FirstAPP
//
//  Created by Mohammed Zaid Khan on 14.08.19.
//  Copyright © 2019 Mohammed Zaid Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var counter:Int64 = 0
    @IBOutlet weak var myFirstLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printLabelValue(label: myFirstLabel, value: counter)
    }

    @IBAction func buttonTapped(_ sender: Any) {
        counter += 1
        printLabelValue(label: myFirstLabel, value: counter)
    }

    @IBAction func resetCounter(_ sender: Any) {
        counter = 0
         printLabelValue(label: myFirstLabel, value: counter)
    }
    
    func printLabelValue(label: UILabel, value: Int64){
         label.text = String(value)
    }
}

