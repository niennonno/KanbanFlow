//
//  AllBoardsTableViewController.swift
//  KanbanFlow
//
//  Created by Aditya Vikram Godawat on 05/04/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit

class AllBoardsTableViewController: UITableViewController {

    //MARK: - User Variables
    
    var accessToken = mAccessToken
    var aResult: NSDictionary!
    var aData: [NSDictionary]!
    var status: NSString!
    
    var aBoardName = [String]()
    
    //MARK: - Overridden Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.aBoardName.removeAll(keepCapacity: true)
        getAllUsers()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - My Own Functions
    
    
    func getAllUsers() {
        
        let aRequest = NSMutableURLRequest(URL: NSURL(string: "http://techiela.com/api/getAllBoards")!)
        
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
                        
                        self.aBoardName.append(data["boardName"] as! String)
                        
                        
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
        return aBoardName.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = aBoardName[indexPath.row]
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
