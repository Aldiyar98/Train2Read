//
//  SchulteTableViewCell.swift
//  Train2Read
//
//  Created by Aldiyar on 16.07.2018.
//  Copyright © 2018 Aldiyar. All rights reserved.
//

import UIKit

class SchulteTableViewCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = 10
        colorView.layer.masksToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
class _SchulteTableViewCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = 10
        colorView.layer.masksToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
