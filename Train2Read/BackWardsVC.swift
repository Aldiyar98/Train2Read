//
//  BackWardsVC.swift
//  Train2Read
//
//  Created by Aldiyar on 26.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import Foundation
import UIKit
class BackWardViewController:UIViewController{
    var whichText = 0
    var converted = false
    var normalTextsArray = [BackWard.citizenNormalText,BackWard.lostJobNormalText,BackWard.paybackNormalText,BackWard.whatHappenedNormalText]
    var backwardTextArray = [BackWard.citizenText,BackWard.lostJobText,BackWard.paybackText,BackWard.whatHappenedText]
    @IBOutlet weak var viewForText: UIView!
    @IBOutlet weak var lastText: UIButton!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var exerciseText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForText.layer.cornerRadius = 10
        viewForText.layer.masksToBounds = true
        convertButton.layer.cornerRadius = 10
        textView.text = normalTextsArray[whichText]
        flashScroll()
        textView.indicatorStyle = .black
        lastText.alpha = 0
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func convertButtonTapped(_ sender: Any) {
        converted = true
        changeExerciseText()
        convertText()
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
        flashScroll()
    }
    
    @IBAction func undoButtonTapped(_ sender: Any) {
        converted = false
        changeExerciseText()
        convertToNormal()
        flashScroll()
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        whichText += 1
        if whichText >= backwardTextArray.count{
            whichText = 0
        }
        checkIndex()
        convertToNormal()
        flashScroll()
    }
    
    @IBAction func lastTextButtonTapped(_ sender: Any) {
        whichText -= 1
        convertToNormal()
        checkIndex()
    }
    
    func flashScroll(){
        textView.flashScrollIndicators()
    }
    
    func convertText(){
        textView.text = backwardTextArray[whichText]
    }
    
    func convertToNormal(){
        textView.text = normalTextsArray[whichText]
    }
    
    func checkIndex(){
        if whichText != 0{
            lastText.alpha = 1
        }else{
            lastText.alpha = 0
        }
    }
    
    func changeExerciseText(){
        if converted{
            exerciseText.text = "Sdrawkcab"
        }else{
            exerciseText.text = "Backwards"
        }
    }
}
