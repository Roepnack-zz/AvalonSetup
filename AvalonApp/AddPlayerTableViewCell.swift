//
//  AddPlayerTableViewCell.swift
//  AvalonApp
//
//  Created by Scott Roepnack on 1/16/16.
//  Copyright © 2016 Scott Roepnack. All rights reserved.
//

import UIKit

class AddPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailTextField: UITextField!
    
    
    @IBAction func AddPlayer(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("AddPlayer", object: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
