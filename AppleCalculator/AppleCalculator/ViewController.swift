//
//  ViewController.swift
//  AppleCalculator
//
//  Created by Natalia on 08.04.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var flag = true
    var firstOperand : Double = 0
    var secondOperand : Double = 0
    var sign = ""
    var flagCommaPressed = false
    
    func doubleOrInt(value: String) -> String {
        let arrValue = value.components(separatedBy: ".")
        
        if arrValue[1] == "0" {
            return arrValue[0]
        } else {
            flagCommaPressed = true
            return value
        }
    }

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func pressedNumberButton(_ sender: UIButton) {
        
        if flag {
            resultLabel.text = sender.currentTitle!
            flag = false
        } else {
            if (resultLabel.text?.characters.count)! < 9 {
                resultLabel.text = resultLabel.text! + sender.currentTitle!
            }
        }
        
    }
    
    @IBAction func pressedSignButton(_ sender: UIButton) {
        firstOperand = Double(resultLabel.text!)!
        flag = true
        flagCommaPressed = false
        sign = sender.currentTitle!
    }
    
    @IBAction func pressedEqualitySignButton(_ sender: UIButton) {
        if !flag {
            secondOperand = Double(resultLabel.text!)!
        }
        
        flagCommaPressed = false
        
        switch sign {
        case "÷":
            if secondOperand != 0 {
                let res = String(firstOperand / secondOperand)
                resultLabel.text = doubleOrInt(value: res)
            }
        case "×":
            let res = String(firstOperand * secondOperand)
            resultLabel.text = doubleOrInt(value: res)
        case "-":
            let res = String(firstOperand - secondOperand)
            resultLabel.text = doubleOrInt(value: res)
        case "+":
            let res = String(firstOperand + secondOperand)
            resultLabel.text = doubleOrInt(value: res)
        default:
            break
        }
    }
    
    @IBAction func pressedClearButton(_ sender: UIButton) {
        resultLabel.text = "0"
        firstOperand = 0
        secondOperand = 0
        sign = ""
        flag = true
        flagCommaPressed = false
    }
    
    @IBAction func pressedPlusMinusButton(_ sender: UIButton) {
        let newValue = -Double(resultLabel.text!)!
        resultLabel.text = doubleOrInt(value: String(newValue))
    }
    
    @IBAction func pressedPersentButton(_ sender: UIButton) {
        if firstOperand != 0 {
            secondOperand = firstOperand * Double(resultLabel.text!)! / 100
        } else {
            let res = String(Double(resultLabel.text!)! / 100)
            resultLabel.text = doubleOrInt(value: res)
        }
        
    }
    
    @IBAction func pressedCommaButton(_ sender: UIButton) {
        if !flagCommaPressed && flag {
            resultLabel.text = "0."
            flagCommaPressed = true
        } else if !flagCommaPressed && !flag {
            resultLabel.text = resultLabel.text! + "."
            flagCommaPressed = true
        }
    }
    
    @IBAction func swipeFunction(_ sender: UISwipeGestureRecognizer) {
        if resultLabel.text!.characters.count > 1 {
            resultLabel.text = String(resultLabel.text!.dropLast())
        } else {
            resultLabel.text = "0"
            firstOperand = 0
            secondOperand = 0
            sign = ""
            flag = true
            flagCommaPressed = false
        }
    }
    
    @IBAction func longPressFunction(_ sender: UILongPressGestureRecognizer) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Скопировать", style: .default, handler: {_ in UIPasteboard.general.string = self.resultLabel.text!})
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

