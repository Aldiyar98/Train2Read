//
//  MixedVC.swift
//  Train2Read
//
//  Created by Aldiyar on 18.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import Foundation
import UIKit
class MixedLetterVC:UIViewController{
    var normalTextsArray = [MixedText.doseNormalText,MixedText.guiltNormalText,MixedText.hullabaloNormalText,MixedText.lostNormalText]
    var mixedTextArray = [MixedText.doseText,MixedText.guiltText,MixedText.hullabaloText,MixedText.lostText]
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewForText: UITextView!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var lastText: UIButton!
    var whichText = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        convertButton.layer.cornerRadius = 10
        viewForText.text = normalTextsArray[whichText]
        flashScroll()
        viewForText.indicatorStyle = .black
        lastText.alpha = 0
    }
    
    @IBAction func convertButtonTapped(_ sender: Any) {
        convertText()
        viewForText.scrollRangeToVisible(NSMakeRange(0, 0))
        flashScroll()
    }
    @IBAction func undoButtonTapped(_ sender: Any) {
        convertToNormal()
        flashScroll()
        viewForText.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        whichText += 1
        if whichText >= mixedTextArray.count{
            whichText = 0
        }
        checkIndex()
        convertToNormal()
        flashScroll()
    }
    
    @IBAction func lastTextTapped(_ sender: Any) {
        whichText -= 1
        convertToNormal()
        checkIndex()
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func convertText(){
        viewForText.text = mixedTextArray[whichText]
    }
    
    func convertToNormal(){
        viewForText.text = normalTextsArray[whichText]
    }
    
    func flashScroll(){
        viewForText.flashScrollIndicators()
    }
    
    func checkIndex(){
        if whichText != 0{
            lastText.alpha = 1
        }else{
            lastText.alpha = 0
        }
    }
    
    
}
