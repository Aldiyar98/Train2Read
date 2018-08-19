//
//  ExercisesVC.swift
//  Train2Read
//
//  Created by Aldiyar on 13.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import UIKit
//1 EXERCISE
class Exercise1ViewController: UIViewController {
    @IBOutlet weak var alertView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    func configureView(){
        alertView.layer.cornerRadius = 10
        alertView.layer.borderColor = UIColor.grays.cgColor
    }
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//2 EXERCISE
class Exercise2ViewController:UIViewController{
    @IBOutlet weak var alertView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        alertView.layer.cornerRadius = 10
        alertView.layer.borderColor = UIColor.grays.cgColor
    }
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
//3 EXERCISE
class Exercise3ViewController:UIViewController{
    @IBOutlet weak var alertView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        alertView.layer.cornerRadius = 10
        alertView.layer.borderColor = UIColor.grays.cgColor
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
//4 EXERCISE
class Exercise4ViewController:UIViewController{
    @IBOutlet weak var alertView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        alertView.layer.cornerRadius = 10
        alertView.layer.borderColor = UIColor.grays.cgColor
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
//5 EXERCISE
class Exercise5ViewController:UIViewController{
    @IBOutlet weak var alertView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        alertView.layer.cornerRadius = 10
        alertView.layer.borderColor = UIColor.grays.cgColor
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

