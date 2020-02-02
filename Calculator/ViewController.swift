//
//  ViewController.swift
//  Calculator
//
//  Created by
//  Copyright © 2020  All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userInTheMiddleOfTyping: Bool = false;
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        print("Touched Digit is \(digit) ")
        if userInTheMiddleOfTyping {
            let  textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    @IBAction func performOperation(_ sender: UIButton) {
        if userInTheMiddleOfTyping{
            brain.setOperand(operand: displayValue)
            userInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol  = sender.currentTitle{
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    

}

