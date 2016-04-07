//
//  DetailViewController.swift
//  AvalonApp
//
//  Created by Scott Roepnack on 1/16/16.
//  Copyright © 2016 Scott Roepnack. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var players: [Player] = []
    var characters: [CharacterDisplayViewModel] = []
    var suggestedGroupComposition: [CharacterDisplayViewModel] = []
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        
        NSLog("Number of Players: \(players.count)")
        
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        let startButton = UIBarButtonItem(
            barButtonSystemItem: .Done,
            target: self,
            action: #selector(DetailViewController.startGame)
        )
        self.navigationItem.rightBarButtonItem = startButton
        
        let nib = UINib(nibName: "RoleCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "RoleCell")
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(DetailViewController.roleCountChange),
            name: "RoleCountChange",
            object: nil
        )
        
        suggestedGroupComposition = CharacterHandler().getDefaults(players.count)
    
        //mutate on local variable
        characters = suggestedGroupComposition
    }

    func startGame() {        
        var charactersToSubmit = [CharacterID: Int]()
        
        var totalCharacters = 0
        for c in characters {
            totalCharacters += c.quantity
            charactersToSubmit[c.character.id] = c.quantity
        }
        
        let vm = CharacterSubmitViewModel(players: players, characters: charactersToSubmit)
        
        
        
        if totalCharacters == vm.players.count {
        
            CharacterHandler().submitCharacters(vm)
        
            performSegueWithIdentifier("showBoard", sender: nil)
        }
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBoard" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! BoardViewController
                        
            let backItem = UIBarButtonItem(title: "Reset", style: .Plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backItem
            
            controller.navigationItem.leftItemsSupplementBackButton = true

        }
    }
    
    func roleCountChange(notification: NSNotification) {
        let characterVm = notification.object as! CharacterDisplayViewModel!
        
        for (c) in characters {
            if c.character.id == characterVm.character.id {
                c.quantity = characterVm.quantity
                break;
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: RoleCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("RoleCell", forIndexPath: indexPath) as! RoleCellTableViewCell
        
        let characterVm = characters[indexPath.row]
        
        cell.CharacterNameLabel.text = characterVm.character.name
        cell.CharacterCountLabel.text = String(characterVm.quantity)
        cell.characterId = characterVm
        cell.stepper.value = Double(characterVm.quantity)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("You selected \(indexPath.section):\(indexPath.row)!")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

