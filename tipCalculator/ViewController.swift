//
//  ViewController.swift
//  tipCalculator
//
//  Created by 고상원 on 2019-05-28.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet var billTextField: UITextField!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var percentageLabel: UILabel!
    @IBOutlet var tipSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private var tipPercentage: Int = 15
    
    @IBAction func calculate(_ sender: UIButton) {
        calculateTip()
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        tipPercentage = Int(sender.value)
        self.percentageLabel.text = "\(tipPercentage)%"
        //calculateTip()
    }
    
    
    func calculateTip() {
        let billAmount = Double(self.billTextField.text ?? "") ?? 0
        let tipAmount = billAmount * (Double(tipPercentage)/100)
        self.tipLabel.text = String(format: "$%.2f", tipAmount)
        let totalAmount = tipAmount + billAmount
        self.totalLabel.text = String(format: "$%.2f", totalAmount)
    }
    
    @objc func keyboardWillBeShown(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height / 2
            }
        }
    }
    
    @objc func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        billTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

