//
//  RoleCellTableViewCell.swift
//  AvalonApp
//
//  Created by Scott Roepnack on 1/16/16.
//  Copyright © 2016 Scott Roepnack. All rights reserved.
//

import UIKit

class RoleCellTableViewCell: UITableViewCell {


    @IBOutlet weak var CharacterNameLabel: UILabel!
    @IBOutlet weak var CharacterCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var characterId: CharacterDisplayViewModel!
    
    
    @IBAction func step(sender: UIStepper) {
        CharacterCountLabel.text = Int(sender.value).description
        characterId.quantity = Int(sender.value)
        NSNotificationCenter.defaultCenter().postNotificationName("RoleCountChange", object: characterId as AnyObject!)
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
