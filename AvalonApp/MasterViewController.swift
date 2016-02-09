//
//  MasterViewController.swift
//  AvalonApp
//
//  Created by Scott Roepnack on 1/16/16.
//  Copyright © 2016 Scott Roepnack. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    var players = [Player]()
    
    var testingPlayers = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "chooseRoles")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        let nib = UINib(nibName: "AddPlayerCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "AddPlayerCell")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addPlayerObject", name: "AddPlayer", object: nil)
        
        //create testing players
        players.append(Player(name:"Scott", email:"Scott.Roepnack@gmail.com"))
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func addPlayerObject() {
        
        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! AddPlayerTableViewCell
        
        let player = Player(
            name: cell.NameTextField.text!,
            email: cell.EmailTextField.text!
        )
        NSLog("Adding Player Row - \(player.description)")
        
        players.insert(player, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        view.endEditing(true)
    }
    
    func chooseRoles() {
        performSegueWithIdentifier("roleSelection", sender: nil)
    }

    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "roleSelection" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.players = players
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return players.count
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell  = tableView.dequeueReusableCellWithIdentifier("AddPlayerCell", forIndexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

            let object = players[indexPath.row]
            cell.textLabel!.text = object.description
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("You selected \(indexPath.section):\(indexPath.row)!")
        view.endEditing(true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 200
        } else {
            return 45
        }
        
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == 0 {
            return false
        } else {
            return true
        }
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath == 0 {
            
        }
        else {
            if editingStyle == .Delete {
                players.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } else if editingStyle == .Insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to   the table view.
            }
        }
    }
}

