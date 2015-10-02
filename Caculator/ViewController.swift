//
//  ViewController.swift
//  Caculator
//
//  Created by 孟若 on 15/9/20.
//  Copyright © 2015年 孟若. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsTyping = false
    
    var operandStack = Array<Double>()
    
    var operational = Array<String>()
    
    @IBAction func clickDigtal(sender: UIButton) {
        let digital = sender.currentTitle!
        if "0123456789.".containsString(digital) {
            if userIsTyping {
                display.text = display.text! + digital
            }
            else {
                display.text = digital
                userIsTyping = true
            }
        }
        else if digital == "CE" {
            display.text = "0"
            operandStack.removeAll()
            operational.removeAll()
            userIsTyping = false
        }
        else if digital == "DEL" {
        }
        else if digital == "=" {
            if userIsTyping {
                saveNumber()
                handle(operational.removeFirst())
                operandStack.removeAll()
            }
        }
        else {
            saveNumber()
            operational.append(digital)
        }

    }
    
    func saveNumber(){
        userIsTyping = false
        operandStack.append(displayValue)
        print(operandStack)
    }
    
    func handle(operate : String){
        switch operate{
        case "+" :
            handleOperatian({$0 + $1})
        case "−" :
            handleOperatian({$0 - $1})
        case "×" :
            handleOperatian({$0 * $1})
        case "÷" :
            handleOperatian({$0 / $1})
        default : break
        }
    }
    
    func handleOperatian (operation : (Double , Double) ->Double){
        if  operandStack.count >= 2 {
            if(operandStack.removeLast() ==0){
                display.text = "0"
            }
            else{
             displayValue = operation(operandStack.removeFirst(),operandStack.removeLast())   
            }
            saveNumber()
        }
    }
    
    var displayValue : Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsTyping = false
        }
    }
}

