//
//  InsertTextVC.swift
//  Train2Read
//
//  Created by Aldiyar on 31.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import Foundation
import UIKit
class InsertTextVC:UIViewController{
    
    @IBOutlet weak var insertedText: UITextView!
    
    var delegate:ChangeValueOfBools?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertedText.becomeFirstResponder()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func insertButtonTapped(_ sender: Any) {
        if insertedText.text.isEmpty{
            let alert = UIAlertController(title: "Your text is empty!", message: "Nothing added", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            UserDefaults.standard.set(insertedText.text, forKey: "insertedText")
            delegate?.changeValues()
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension InsertTextVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InsertTextVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
protocol ChangeValueOfBools {
    func changeValues()
}
