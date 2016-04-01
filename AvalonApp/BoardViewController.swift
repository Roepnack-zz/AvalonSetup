//
//  BoardViewController.swift
//  AvalonApp
//
//  Created by Scott Roepnack on 1/30/16.
//  Copyright © 2016 Scott Roepnack. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {

    
    @IBOutlet var questOneButton: UIButton!
    @IBOutlet var questTwoButton: UIButton!
    @IBOutlet var questThreeButton: UIButton!
    @IBOutlet var questFourButton: UIButton!
    @IBOutlet var questFiveButton: UIButton!

    var buttonState = [Int: String]()
    
    @IBAction func updateQuest(sender: AnyObject) {
        let button = sender as! UIButton
        let state = buttonState[button.tag]
        
        var nextState = String()
        if state == "grey" {
            nextState = "blue"
        } else if state == "blue" {
            nextState = "red"
        } else if state == "red" {
            nextState = "grey"
        }
        buttonState[button.tag] = nextState
        
        let image = UIImage(named: "\(nextState).png")
        button.setImage(image, forState: .Normal)

    }
    

    @IBAction func updatePlayerCount(sender: UIButton) {
        
        var count: Int = Int(sender.titleLabel!.text!)!
        count += 1
        
        if count > 8 {
            count = 1
        }
        
        sender.setTitle(count.description, forState: .Normal)
        
    }
    @IBAction func twoFailsRequired(sender: UIButton) {
        
        let current = sender.titleLabel!.text!
        if current == "Yes" {
            sender.setTitle("No", forState: .Normal)
        }
        else {
            sender.setTitle("Yes", forState: .Normal)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var buttons: [UIButton] = [
            questOneButton,
            questTwoButton,
            questThreeButton,
            questFourButton,
            questFiveButton,
        ]
        let image = UIImage(named: "grey.png")
        for n in 0...4 {
            buttonState[n] = "grey"
            let button = buttons[n]
            button.tag = n
            button.setImage(image, forState: .Normal)
        }
        
        self.navigationItem.backBarButtonItem?.title = "Back"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
