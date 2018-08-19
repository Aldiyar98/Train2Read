//
//  TableViewCell.swift
//  Train2Read
//
//  Created by Aldiyar on 13.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var exDescription: UILabel!
    @IBOutlet weak var exName: UILabel!
    @IBOutlet weak var exIcon: UIImageView!
    @IBOutlet weak var exView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        exView.layer.borderColor = UIColor.grays.cgColor
        exView.layer.borderWidth = 2
        exView.layer.masksToBounds = true
        exDescription.numberOfLines = 0
    }
}
