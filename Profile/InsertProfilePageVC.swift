//
//  InsertProfilePageVC.swift
//  Train2Read
//
//  Created by Aldiyar on 30.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//
import Foundation
import UIKit
class InsertProfileVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var isClosed = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        if sender.image(for:.normal ) == #imageLiteral(resourceName: "getStarted1per") && !(textField.text?.isEmpty)!{
            UIView.animate(withDuration: 0.5, animations: {
                sender.alpha = 0
                sender.setImage(#imageLiteral(resourceName: "getStartedHalf"), for: .normal)
                sender.alpha = 1
            }, completion: nil)
            textField.text = ""
        }else if sender.image(for:.normal ) == #imageLiteral(resourceName: "getStartedHalf") && !(textField.text?.isEmpty)!{
            sender.setImage(#imageLiteral(resourceName: "getStartedFully"), for: .normal)
        }
    }
}
