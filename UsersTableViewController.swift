//
//  UsersTableViewController.swift
//  ScrollableViews
//
//  Created by Joe E. on 12/17/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import Parse

private let CELL = "Cell"

class UsersTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL, forIndexPath: indexPath) as UITableViewCell
        var usersArray:[String] = []
        let query = PFUser.query()?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            guard let returnedObjects = objects else { return }
            guard let users = returnedObjects as? [PFObject] else { return }
            for user in users {
                guard let username = user["username"] as? String else { return }
                usersArray.append(username)
                
                cell.textLabel?.text = usersArray[indexPath.row]
                cell.detailTextLabel?.text = "Points: 0"
                cell.imageView?.image = UIImage(named: "Dude")
                
            }
            
        })

        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let username = PFUser.currentUser()?.username else { return }
        print("username \(username)")
        guard let id = PFUser.currentUser()?.objectId else { return }
        let msg = "\(username) is now following you."
        
        let pushQuery = PFInstallation.query()?.whereKey("installationUser", equalTo: id)
        let push = PFPush()
        push.setQuery(pushQuery)
        push.setMessage(msg)
        push.sendPushInBackgroundWithBlock { (bool, error) -> Void in
            if error != nil {
                print("error \(error)")
                
            } else {
                print("completed")
                
            }
            
        }
        
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
    }


    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
