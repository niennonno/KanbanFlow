//
//  allUserTableTableViewController.swift
//  KanbanFlow
//
//  Created by Aditya Vikram Godawat on 30/03/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit

class allUserTableTableViewController: UITableViewController {
    
    //MARK: - Variables
    
    let accessToken = mAccessToken
    
    var aResult: NSDictionary!
    var aData: [NSDictionary]!
    var status: NSString!
    
    var aFullName = [String]()
    var aUserId = [String]()
    var aEmail = [String]()
    var selectedRow = Int()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.aFullName.removeAll(keepCapacity: true)
        self.aUserId.removeAll(keepCapacity: true)
        self.aEmail.removeAll(keepCapacity: true)
        
        
        getAllUsers()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - My Own Functions
    
    
    func getAllUsers() {
        
        let aRequest = NSMutableURLRequest(URL: NSURL(string: "http://techiela.com/api/getAllUsers")!)
        
        aRequest.HTTPMethod = "GET"
        aRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let aGroup = dispatch_group_create()
        dispatch_group_enter(aGroup)
        
        let aTask = NSURLSession.sharedSession().dataTaskWithRequest(aRequest, completionHandler: { (aData: NSData?,  aResponse: NSURLResponse?, aError: NSError?) -> Void in
            if let aHttpResponse = aResponse as? NSHTTPURLResponse {
                
                if aHttpResponse.statusCode == 200 {
                    
                    self.aResult = (try! NSJSONSerialization.JSONObjectWithData(aData!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary

                    self.status = self.aResult["status"] as! String
                    self.aData = self.aResult["data"] as! [NSDictionary]
                    
                    for data in self.aData {
                        
                        self.aFullName.append(data["fullName"] as! String)
                        self.aUserId.append(data["_id"] as! String)
                        self.aEmail.append(data["email"] as! String)
                    
                    }
                    
                   // print(self.aUserId)
                    
                }
                    dispatch_group_leave(aGroup)
                    

            } else {
                print(aError?.localizedDescription)
                dispatch_group_leave(aGroup)
            }
        })
        aTask.resume()
        
        dispatch_group_wait(aGroup, DISPATCH_TIME_FOREVER)
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.aFullName.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserTableViewCell
        
        cell.nameLabel.text = aFullName[indexPath.row]
        cell.emailLabel.text = aEmail[indexPath.row]
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedRow = indexPath.row
        
        performSegueWithIdentifier("userDetails", sender: self)
    
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        
        if segue.identifier == "userDetails" {
            
            if let destination = segue.destinationViewController as? UserDetailsTableViewController {
                
               destination.aUsername = aFullName[selectedRow]
               destination.aId = aUserId[selectedRow]
                
            }
            
        }
        
    }

}
