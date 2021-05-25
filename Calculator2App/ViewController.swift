//
//  ViewController.swift
//  Calculator2App
//
//  Created by Kevin Patel on 5/24/21.
//

import UIKit

enum Operations: String {
    case Add = "+"
    case Subtract = "-"
    case Multiply = "*"
    case Divide = "/"
    case Clear = "Null"
}

class ViewController: UIViewController {
    
    var numberValue = ""
    var lValue = ""
    var rValue = ""
    var currOperation : Operations = .Clear
    var result = ""
    
    @IBOutlet var landscapeStackView: UIStackView!
    @IBOutlet var portraitStackView: UIStackView!
    
    @IBOutlet var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateView()
    }
    
    func updateView() {
        if UIDevice.current.orientation.isLandscape{
            landscapeStackView.isHidden = false
        } else {
            landscapeStackView.isHidden = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateView()
    }
    
    @IBAction func clearBtn(_ sender: UIButton) {
        numberValue = ""
        lValue = ""
        rValue = ""
        currOperation = .Clear
        numberLabel.text = "0"
    }
    
    @IBAction func numberBtn(_ sender: UIButton) {
        if numberValue.count <= 8 {
            numberValue += "\(sender.tag)"
            numberLabel.text = numberValue
        }
    }
    
    @IBAction func dotBtn(_ sender: UIButton) {
        if numberValue.count <= 7 {
            if numberValue.contains("."){
                numberLabel.text = numberValue
            } else {
                numberValue += "."
                numberLabel.text = numberValue
            }
        }
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        operation(operation: .Add)
    }
    
    @IBAction func subtractBtn(_ sender: UIButton) {
        operation(operation: .Subtract)
    }
    
    @IBAction func multiplyBtn(_ sender: UIButton) {
        operation(operation: .Multiply)
    }
    
    @IBAction func divideBtn(_ sender: UIButton) {
        operation(operation: .Divide)
    }
    
    @IBAction func equalBtn(_ sender: UIButton) {
        operation(operation: currOperation)
    }
    
    func operation (operation : Operations){
        if currOperation != .Clear {
            if numberValue != "" {
                rValue = numberValue
                numberValue = ""
                
                if currOperation == .Add {
                    result = "\(Double(lValue)! + Double(rValue)!)"
                } else if currOperation == .Subtract {
                    result = "\(Double(lValue)! - Double(rValue)!)"
                } else if currOperation == .Multiply {
                    result = "\(Double(lValue)! * Double(rValue)!)"
                } else if currOperation == .Divide {
                    result = "\(Double(lValue)! / Double(rValue)!)"
                }
                lValue = result
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                numberLabel.text = result
            }
            currOperation = operation
        } else {
            lValue = numberValue
            numberValue = ""
            currOperation = operation
        }
    }
}

