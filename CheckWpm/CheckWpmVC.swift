//
//  CheckWpmVC.swift
//  Train2Read
//
//  Created by Aldiyar on 13.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import Foundation
import UIKit
class CheckWpm:UIViewController,ChangeValueOfBools{
    
    @IBOutlet weak var dropDownMenu: UIView!
    @IBOutlet weak var wpmLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var words: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var saveWpmLabel: UILabel!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var alertView: UIView!
    
    var timer = Timer()
    var isChanged = false
    var isStarted = false
    var isTransferring = false
    var text = [MixedText.doseNormalText,MixedText.guiltNormalText,MixedText.hullabaloNormalText,MixedText.lostNormalText]
    var indexOfText = 0
    var indexOfWord = 0
    var wpm = 0
    var arrayOfWpms:[String] = []
    var arrayOfWords:[String] = []
    var speed:Double = 0
    var elapseTime:Double = 0
    var hasInsertedText = false
    var hasInsertedTextDidLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giveValuesToDropDownMenu()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.reloadData()
        dropDownMenu.layer.borderWidth = 1
        dropDownMenu.layer.borderColor = UIColor.bereza.cgColor
        dropDownMenu.layer.masksToBounds = true
        dropDownMenu.alpha = 0
        blurEffect.alpha = 0
        alertView.alpha = 0
        
        setArrayValues()
        changeTheWord()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toInsertText") {
            let vc = segue.destination as! InsertTextVC
            vc.delegate = self
        }
    }
    
    @IBAction func repeatButtonTapped(_ sender: Any) {
        correctValuesForRepeatAndChanging()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        changeImageOfButton()
        isTransferring = !isTransferring
        elapseTime = speed * Double(arrayOfWords.count)
        if isTransferring{
            runWpm()
        }else{
            timer.invalidate()
        }
    }
    
    @IBAction func setWpmButtonTapped(_ sender: UIButton) {
        setDropDownMenu()
        timer.invalidate()
        playButton.setImage(#imageLiteral(resourceName: "playforwpm"), for: .normal)
    }
    
    @IBAction func lastTextWpmTapped(_ sender: UIButton) {
        indexOfText -= 1
        if indexOfText < 0  {
            indexOfText = 0
        }
        correctValuesForRepeatAndChanging()
    }
    
    @IBAction func nextTextWpmTapped(_ sender: UIButton) {
        indexOfText += 1
        if indexOfText >= text.count{
            if hasInsertedTextDidLoad{
                if let insertedText = UserDefaults.standard.string(forKey: "insertedText"){
                    text.append(insertedText)
                    hasInsertedTextDidLoad = false
                }
            }
            if hasInsertedText{
                if let insertedText = UserDefaults.standard.string(forKey: "insertedText"){
                    text.remove(at: text.count - 1)
                    text.append(insertedText)
                    hasInsertedText = false
                }
            }
        }
        if indexOfText >= text.count{
            indexOfText -= 1
        }
        correctValuesForRepeatAndChanging()
    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.alertView.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.blurEffect.alpha = 0
        }, completion: nil)
    }
    
    @IBAction func exitAlertViewButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.alertView.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.blurEffect.alpha = 0
        }, completion: nil)
    }
    
    @IBAction func insertTextButtonTapped(_ sender: Any) {
        correctValuesForRepeatAndChanging()
    }
    
    func changeValues() {
        hasInsertedText = true
        hasInsertedTextDidLoad = false
    }
    
    func correctValuesForRepeatAndChanging(){
        timer.invalidate()
        isTransferring = true
        setArrayValues()
        changeImageOfButton()
        changeTheWord()
        isTransferring = false
    }
    
    func changeImageOfButton(){
        if isTransferring{
            playButton.setImage(#imageLiteral(resourceName: "playforwpm"), for: .normal)
            let currentWpm = Double(wpmLabel.text!)
            speed = 60 / currentWpm!
        }else{
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            let currentWpm = Double(wpmLabel.text!)
            speed = 60 / currentWpm!
        }
    }
    
    func runWpm(){
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(speed), target: self,   selector: (#selector(CheckWpm.updateWord)), userInfo: nil, repeats: true)
    }
    
    @objc func updateWord(){
        if elapseTime <= 0{
            saveWpmLabel.text = wpmLabel.text!+" wpm"
            UIView.animate(withDuration: 0.2, animations: {
                self.alertView.alpha = 1
            }, completion: nil)
            UIView.animate(withDuration: 1, animations: {
                self.blurEffect.alpha = 1
            }, completion: nil)
            correctValuesForRepeatAndChanging()
        }else{
            if indexOfWord < arrayOfWords.count{
                words.text = arrayOfWords[indexOfWord]
                indexOfWord += 1
                elapseTime -= speed
            }else{
                indexOfWord -= 1
            }
        }
    }
    
    func giveValuesToDropDownMenu(){
        for i in 30..<1000{
            if i % 5 == 0{
                arrayOfWpms.append("\(i)")
            }
        }
    }
    
    func changeTheWord(){
        words.text = arrayOfWords[0]
        indexOfWord = 0
    }
    
    func setArrayValues(){
        if isTransferring{
            arrayOfWords.removeAll()
            for i in text[indexOfText].components(separatedBy: .whitespacesAndNewlines){
                arrayOfWords.append(String(i))
            }
        }else{
            for i in text[indexOfText].components(separatedBy: .whitespacesAndNewlines){
                arrayOfWords.append(String(i))
            }
        }
    }
    
    func setDropDownMenu(){
        isChanged = !isChanged
        if isChanged{
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropDownMenu.alpha = 1
                self.dropDownMenu.center.y += 10
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropDownMenu.alpha = 0
                self.dropDownMenu.center.y -= 10
                self.correctValuesForRepeatAndChanging()
            }, completion: nil)
        }
    }
}
extension CheckWpm:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfWpms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WpmCell
        cell.number.text = arrayOfWpms[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        wpmLabel.text = arrayOfWpms[indexPath.row]
        setDropDownMenu()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 27
    }
}
