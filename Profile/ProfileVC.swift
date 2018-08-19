//
//  ProfileVC.swift
//  Train2Read
//
//  Created by Aldiyar on 28.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
class ProfileViewController: UIViewController{
    
    @IBOutlet weak var nameSurname: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    @IBOutlet weak var achievementTextView: UITextView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    var nameIsChanging = false
    var targetIsChanging = false
    var achievementIsChanging = false
    var viewIsVisible = false
    var isProcessed = false
    var arrayOfWords:[String] = []
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setProfile()
        settingView.alpha = 0
        blurEffect.alpha = 0
    }
    
    func setProfile(){
        if let name = UserDefaults.standard.string(forKey: "name"){
            nameSurname.text = name
        }else{
            nameSurname.text = "Name Surname"
        }
        if let target = UserDefaults.standard.string(forKey: "target"){
            targetTextView.text = target
        }else{
            targetTextView.text = "00 wpm"
        }
        if let achievement = UserDefaults.standard.string(forKey: "achievement"){
            achievementTextView.text = achievement
        }else{
            achievementTextView.text = "00 wpm"
        }
    }
    
    @IBAction func setNameButtonTapped(_ sender: UIButton) {
        nameIsChanging = !nameIsChanging
        if nameIsChanging{
            nameSurname.isEditable = true
            nameSurname.becomeFirstResponder()
            sender.setImage(#imageLiteral(resourceName: "saveProfile"), for: .normal)
            nameSurname.text = ""
        }else{
            sender.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
            if nameSurname.text.isEmpty{
                setProfile()
            }else{
                UserDefaults.standard.set(nameSurname.text, forKey: "name")
                setProfile()
            }
            nameSurname.isEditable = false
        }
    }
    
    @IBAction func setTargetButtonTapped(_ sender: UIButton) {
        targetIsChanging = !targetIsChanging
        if targetIsChanging{
            targetTextView.isEditable = true
            targetTextView.becomeFirstResponder()
            sender.setImage(#imageLiteral(resourceName: "saveProfile"), for: .normal)
            targetTextView.text = ""
        }else{
            sender.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
            if targetTextView.text.isEmpty{
                setProfile()
            }else{
                UserDefaults.standard.set(targetTextView.text + " wpm", forKey: "target")
                setProfile()
            }
            targetTextView.isEditable = false
        }
    }
    
    @IBAction func setAchievementButtonTapped(_ sender: UIButton) {
        achievementIsChanging = !achievementIsChanging
        if achievementIsChanging{
            achievementTextView.isEditable = true
            achievementTextView.becomeFirstResponder()
            sender.setImage(#imageLiteral(resourceName: "saveProfile"), for: .normal)
            achievementTextView.text = ""
        }else{
            sender.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
            if achievementTextView.text.isEmpty{
                setProfile()
            }else{
                UserDefaults.standard.set(achievementTextView.text + " wpm", forKey: "achievement")
                setProfile()
            }
            achievementTextView.isEditable = false
        }
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        viewIsVisible = !viewIsVisible
        if viewIsVisible{
            UIView.animate(withDuration: 0.5) {
                self.settingView.alpha = 1
            }
            UIView.animate(withDuration: 0.7) {
                self.blurEffect.alpha = 1
            }
        }else{
            UIView.animate(withDuration: 0.7) {
                self.settingView.alpha = 0
            }
            UIView.animate(withDuration: 0.5) {
                self.blurEffect.alpha = 0
            }
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let image = UIImage(named: "shareScreen")
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func contactButtonTapped(_ sender: Any) {
        let composer = MFMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            composer.mailComposeDelegate = self
            composer.setToRecipients(["dairbekov695@gmail.com"])
            composer.setSubject("SPREEAD Application")
            present(composer, animated: true, completion: nil)
        }
    }

}

extension ProfileViewController:MFMailComposeViewControllerDelegate{
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WideningViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
        UIView.animate(withDuration: 0.7) {
            self.settingView.alpha = 0
        }
        UIView.animate(withDuration: 0.5) {
            self.blurEffect.alpha = 0
        }
    }
    
}
