//
//  NumbersSchulteTable.swift
//  Train2Read
//
//  Created by Aldiyar on 31.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
class SchulteTableNumbers: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentNumber: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var pauseView:UIView!
    @IBOutlet weak var spentTime:UILabel!
    
    var arrayOfNumbers:[String] = []
    var arrayOfContinuedNumbers:[String] = []
    var arrayOfInitialNumbers:[String] = []
    var isProcessing = false
    var isStopped = false
    var isPlaying = false
    var timer = Timer()                
    var player: AVAudioPlayer?
    var time = 0
    var current = 0
    var tapped = 0
    var isFirstProcess = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNumbers()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = false
        blurEffect.alpha = 0
        pauseView.alpha = 0
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        isProcessing = !isProcessing
        if isProcessing{
            isStopped = true
            sender.setTitle("Stop", for: .normal)
            collectionView.isUserInteractionEnabled = true
            runTimer()
            arrayOfNumbers = arrayOfContinuedNumbers
            if isFirstProcess == 1{
                arrayOfNumbers = generateRandomNumber(from: 1, to: 25, qut: 25)
                isFirstProcess -= 1
            }
            arrayOfContinuedNumbers = arrayOfNumbers
            collectionView.reloadData()
        }else{
            if isStopped{
                sender.setTitle("Continue", for: .normal)
            }else{
                sender.setTitle("Start", for: .normal)
            }
            collectionView.isUserInteractionEnabled = false
            timer.invalidate()
            setArrayIfStopped()
            collectionView.reloadData()
            isStopped = false
        }
    }
    
    @IBAction func mixButtonTapped(_ sender: Any) {
        prepareValuesForRepeat()
    }
    
    @IBAction func okAlertButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.pauseView.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.blurEffect.alpha = 0
        }, completion: nil)
    }
    
    @IBAction func soundButtonTapped(_ sender: UIButton) {
        isPlaying = !isPlaying
        if isPlaying{
            sender.setImage(UIImage(named: "sound off"), for: .normal)
        }else{
            sender.setImage(UIImage(named:"sound on"), for: .normal)
        }
    }
    
    
    func prepareValuesForRepeat(){
        arrayOfNumbers.removeAll()
        setNumbers()
        startButton.setTitle("Start", for: .normal)
        timer.invalidate()
        isFirstProcess = 1
        time = 0
        current = 0
        currentNumber.text = "\(current+1)"
        timeLabel.text = "\(time)"
        isProcessing = false
        collectionView.isUserInteractionEnabled = false
        collectionView.reloadData()
    }
    
    func setNumbers(){
        for i in 1..<26{
            arrayOfNumbers.append(String(i))
            arrayOfInitialNumbers.append(String(i))
        }
        arrayOfContinuedNumbers = arrayOfNumbers
    }
    
    func setArrayIfStopped(){
        arrayOfNumbers.removeAll()
        for _ in 1..<26{
            arrayOfNumbers.append("")
        }
    }
}
extension SchulteTableNumbers: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NumberCollectionViewCell
        cell.number.text = arrayOfNumbers[indexPath.row]
        return cell
    }
    
    func generateRandomNumber(from:Int , to:Int , qut:Int?) ->[String]{
        var myrandomNumbers = [String]()
        var numberOfNumbers = qut
        let lower = UInt32(from)
        let higher = UInt32(to+1)
        if numberOfNumbers == nil || numberOfNumbers! > (to-from) + 1{
            numberOfNumbers = (to - from) + 1
        }
        while myrandomNumbers.count != numberOfNumbers{
            let myNumber = arc4random_uniform(higher-lower) + lower
            if !myrandomNumbers.contains((String(myNumber))){
                myrandomNumbers.append(String(myNumber))
            }
        }
        return myrandomNumbers
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(SchulteTableNumbers.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        time += 1
        timeLabel.text = "\(time)"
    }
    
    func playRightClickSound() {
        guard let url = Bundle.main.url(forResource: "smb_coin", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else {return}
            player.play()
            if isPlaying{
                player.volume = 0.0
            }else{
                player.volume = 1
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playWrongClickSound(){
        guard let url = Bundle.main.url(forResource: "smb_bump", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else {return}
            player.play()
            if isPlaying{
                player.volume = 0.0
            }else{
                player.volume = 1
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension SchulteTableNumbers: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 4 * 8) / 5
        let height = (collectionView.frame.height - 4 * 8) / 5
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapped = current
        if current < arrayOfNumbers.count-1{
            if arrayOfInitialNumbers[current] == arrayOfNumbers[collectionView.indexPathsForSelectedItems![0][1]]{
                playRightClickSound()
                current += 1
                currentNumber.text = "\(current+1)"
            }else{
                playWrongClickSound()
                current -= 1
                if current<tapped{
                    current += 1
                }
            }
        }else{
            spentTime.text = "\(time) seconds"
            UIView.animate(withDuration: 0.2, animations: {
                self.pauseView.alpha = 1
            }, completion: nil)
            UIView.animate(withDuration: 1, animations: {
                self.blurEffect.alpha = 1
            }, completion: nil)
            prepareValuesForRepeat()
        }
    }
}


