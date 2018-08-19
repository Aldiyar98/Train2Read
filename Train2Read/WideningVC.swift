//
//  WideningVC.swift
//  Train2Read
//
//  Created by Aldiyar on 16.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import Foundation
import UIKit
class WideningViewController:UIViewController{
    var firstNum = 0
    var secondNum = 0
    var first = false
    var check = true
    var beginnerLevel = false
    var advancedLevel = false
    var x1 = CGFloat()
    var x2 = CGFloat()
    var distance = CGFloat()
    @IBOutlet weak var mainDist: UILabel!
    @IBOutlet weak var distInView: UILabel!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var viewConc: UIView!
    @IBOutlet weak var firstNumber: UILabel!
    @IBOutlet weak var secondNumber: UILabel!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var textFieldFirstNum: UITextField!
    @IBOutlet weak var textFieldSecNum: UITextField!
    @IBOutlet weak var failure: UIImageView!
    @IBOutlet weak var success: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseView.alpha = 0
        pauseView.layer.cornerRadius = 20
        blurEffect.alpha = 0
        randomTheNumbers()
        firstNumber.alpha = 0
        secondNumber.alpha = 0
        gameView.layer.cornerRadius = 20
        firstNumber.text = String(firstNum)
        secondNumber.text = String(secondNum)
        failure.alpha = 0
        success.alpha = 0
        hideKeyboardWhenTappedAround()
        viewConc.layer.cornerRadius = 10
        configureTextField()
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        sender.setImage(#imageLiteral(resourceName: "checkButton"), for: .normal)
        sender.isUserInteractionEnabled = false
        textFieldFirstNum.isEnabled = true
        textFieldSecNum.isEnabled = true
        if first{
            if textFieldFirstNum.text == firstNumber.text && textFieldSecNum.text == secondNumber.text{
                animateSuccess()
                increasePositionOfNumbers()
            }else{
                animateFailure()
                decreasePositionOfNumbers()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.3, animations: {
                self.firstNumber.alpha = 1
                self.secondNumber.alpha = 1
            }, completion: nil)
            self.textFieldFirstNum.becomeFirstResponder()
            self.animate()
            self.randomTheNumbers()
        }
        sender.isUserInteractionEnabled = true
        first = true
        
    }
    
    @IBAction func pauseButtonTapped(_ sender: Any){
        distInView.text = mainDist.text
        UIView.animate(withDuration: 0.2, animations: {
            self.pauseView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.blurEffect.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func repeatButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.pauseView.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.blurEffect.alpha = 0
        }, completion: nil)
    }
    
    @IBAction func viewPHomeButtonTapped(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.pauseView.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.blurEffect.alpha = 0
        }, completion: nil)
    }
    
    func randomTheNumbers(){
        firstNum = Int(arc4random_uniform(100)+1)
        secondNum = Int(arc4random_uniform(100)+1)
        firstNumber.text = String(firstNum)
        secondNumber.text = String(secondNum)
    }
    
    func animate(){
        UIView.animate(withDuration: 0.2, animations: {
            self.firstNumber.alpha = 0
            self.secondNumber.alpha = 0
        }, completion: nil)
    }
    
    func configureTextField(){
        textFieldFirstNum.layer.borderWidth = 1
        textFieldSecNum.layer.borderWidth = 1
        textFieldSecNum.layer.borderColor = UIColor.bereza.cgColor
        textFieldFirstNum.layer.borderColor = UIColor.bereza.cgColor
        textFieldSecNum.layer.cornerRadius = 5
        textFieldFirstNum.layer.cornerRadius = 5
        textFieldFirstNum.isEnabled = false
        textFieldSecNum.isEnabled = false
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    func increasePositionOfNumbers(){
        if check{
            x1 = firstNumber.frame.origin.x
            x2 = secondNumber.frame.origin.x
            check = false
        }
        if firstNumber.frame.origin.x != 0{
            beginnerLevel = true
            advancedLevel = false
            firstNumber.frame.origin.x -= 10
            findDistance()
        }else if secondNumber.frame.origin.x != UIScreen.main.bounds.width-10{//changed
            advancedLevel = true
            beginnerLevel = false
            findDistance()
            secondNumber.frame.origin.x += 10
        }else{
            findDistance()
            beginnerLevel = false
            advancedLevel = false
            firstNumber.frame.origin.x = x1
            secondNumber.frame.origin.x = x2
            UIView.animate(withDuration: 0.2, animations: {
                self.pauseView.alpha = 1
            }, completion: nil)
            UIView.animate(withDuration: 1, animations: {
                self.blurEffect.alpha = 1
            }, completion: nil)
        }
    }
    func findDistance(){
        distance = secondNumber.frame.origin.x - firstNumber.frame.origin.x
        mainDist.text = distance.description
        distInView.text = distance.description
    }
    func decreasePositionOfNumbers(){
        let dist = distance.description
        if dist != "100.0"{
            if beginnerLevel{
                firstNumber.frame.origin.x += 10
                findDistance()
            }else if advancedLevel{
                secondNumber.frame.origin.x -= 10
                findDistance()
            }
            findDistance()
        }else{
            findDistance()
        }
    }
    
    func animateSuccess(){
        UIView.animate(withDuration: 1, animations: {
            self.success.alpha = 1
            self.success.alpha = 0
            self.emptyTheTextFields()
        }, completion: nil)
    }
    
    func animateFailure(){
        UIView.animate(withDuration: 1, animations: {
            self.failure.alpha = 1
            self.failure.alpha = 0
            self.emptyTheTextFields()
        }, completion: nil)
        
    }
    
    func emptyTheTextFields(){
        textFieldFirstNum.text = ""
        textFieldSecNum.text = ""
    }
}

extension WideningViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WideningViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
