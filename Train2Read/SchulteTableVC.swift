//
//  SchulteTableVC.swift
//  Train2Read
//
//  Created by Aldiyar on 16.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import Foundation
import UIKit
class SchulteTableViewController:UIViewController{
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var secondTableView: UITableView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var scoreView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    
    var count = 0
    var random = [Int]()
    var random2 = [Int]()
    var celltoReturn = UITableViewCell()
    var score = 0
    var seconds = 30
    var timer = Timer()
    var isTimerRunning = false
    let colorsArray = [
        UIColor.dark,UIColor.blue,UIColor.green,UIColor.yellow,UIColor.brown,UIColor.purple,UIColor.red,
        UIColor.orange,
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTableView.delegate = self
        firstTableView.separatorStyle = .none
        firstTableView.dataSource = self
        secondTableView.delegate = self
        secondTableView.separatorStyle = .none
        secondTableView.dataSource = self
        pauseView.layer.cornerRadius = 20
        pauseView.alpha = 0
        blurEffect.alpha = 0
        equalTheArray()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.runTimer()
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        UIView.animate(withDuration: 0.2, animations: {
            self.pauseView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.blurEffect.alpha = 1
        }, completion: nil)
        timeView.text = String(seconds) + "sec"
        scoreView.text = String(score)
    }
   
    @IBAction func playButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1, animations: {
            self.pauseView.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.blurEffect.alpha = 0
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.runTimer()
        }
    }
    
    @IBAction func repeatButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        seconds = 60
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.runTimer()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.8, animations: {
            self.pauseView.alpha = 0
            self.blurEffect.alpha = 0
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.runTimer()
        }
    }
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension SchulteTableViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == firstTableView{
            for i in 0..<random.count{
                if random[indexPath.row] == random2[i]{
                    score += 5
                }
            }
        }else{
            for i in 0..<random2.count{
                if random2[indexPath.row] == random[i]{
                    score += 5
                }
            }
        }
        equalTheArray()
        scoreLabel.text = String(score)
        firstTableView.reloadData()
        secondTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.firstTableView{
            let cell1 = firstTableView.dequeueReusableCell(withIdentifier: "color", for: indexPath) as! SchulteTableViewCell
            cell1.colorView.backgroundColor = colorsArray[random[indexPath.row]]
            celltoReturn = cell1
        }else if tableView == self.secondTableView{
            let cell2 = secondTableView.dequeueReusableCell(withIdentifier: "color", for: indexPath) as! _SchulteTableViewCell
            cell2.colorView.backgroundColor = colorsArray[random2[indexPath.row]]
            celltoReturn = cell2
        }
        return celltoReturn
    }
    func checkIfTwoBlocksAreSame(){
        for i in random{
            for k in random2{
                if i==k{
                    count += 1
                }
            }
        }
        if count > 2{
            equalTheArray()
            print("checked")
        }
    }
    
    func equalTheArray(){
        random = generateRandomNumber(from: 0, to: 7, qut: 5)
        random2 = generateRandomNumber(from: 0, to: 7, qut: 5)
//        checkIfTwoBlocksAreSame() очень  много рекурсива добавь новые цвета и 5
    }
    
    func generateRandomNumber(from:Int , to:Int , qut:Int?) ->[Int]{
        var myrandomNumbers = [Int]()
        var numberOfNumbers = qut
        let lower = UInt32(from)
        let higher = UInt32(to+1)
        if numberOfNumbers == nil || numberOfNumbers! > (to-from) + 1{
            numberOfNumbers = (to - from) + 1
        }
        while myrandomNumbers.count != numberOfNumbers{
            let myNumber = arc4random_uniform(higher-lower) + lower
            if !myrandomNumbers.contains((Int(myNumber))){
                myrandomNumbers.append(Int(myNumber))
            }
        }
        return myrandomNumbers
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(SchulteTableViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1
        timerLabel.text = "\(seconds)"
        if seconds == 0{
            timer.invalidate()
            UIView.animate(withDuration: 0.5, animations: {
                self.pauseView.alpha = 1
            }, completion: nil)
            UIView.animate(withDuration: 1, animations: {
                self.blurEffect.alpha = 1
            }, completion: nil)
            timeView.text = "Time's up"
            scoreView.text = String(score)
            seconds = 30
            score = 0
            
        }
    }
}
