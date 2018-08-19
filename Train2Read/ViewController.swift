//
//  ViewController.swift
//  Train2Read
//
//  Created by Aldiyar on 13.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import UIKit
class ExercisesViewController: UIViewController {
    var arrayOfImages = ["widening","grid","feedback","numberTable","backward-time"]
    var arrayOfDescriptions = [Description.widening,Description.schulte,Description.mixed,Description.schulteNumber, Description.backwards]
    var arrayOfNames = [Names.widening,Names.schulte,Names.mixed,Names.schulteNumber, Names.backwards]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.headerView(forSection: 1)
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
    }
}
extension ExercisesViewController:UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.exDescription.text = arrayOfDescriptions[indexPath.row]
        cell.exName.text = arrayOfNames[indexPath.row]
        cell.exIcon.image = UIImage(named:arrayOfImages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.bounds.height-28)/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            performSegue(withIdentifier: "widening", sender: Any?.self)
        }else if indexPath.row == 1{
            performSegue(withIdentifier: "schulte", sender: Any?.self)
        }else if indexPath.row == 2{
            performSegue(withIdentifier: "mixed", sender: Any?.self)
        }else if indexPath.row == 3{
            performSegue(withIdentifier: "readonly", sender: Any?.self)
        }else{
            performSegue(withIdentifier: "backwards", sender: Any?.self)
        }
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TableViewCell {
            cell.exView.dropShadow(color: .backGround, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true,size:CGSize(width: cell.bounds.width-16, height: cell.bounds.height-8))
        }
    }
}
