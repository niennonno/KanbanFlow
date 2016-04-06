//
//  UserDetailsTableViewController.swift
//  KanbanFlow
//
//  Created by Aditya Vikram Godawat on 30/03/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit

class UserDetailsTableViewController: UITableViewController {

    
    // MARK: - User Variables
    var aUsername = ""
    var aResult: NSDictionary!
    var aId = ""
    var accessToken = mAccessToken
    
    var aData: [NSDictionary]!
    var status: NSString!

    
    struct userData {
        
        var boardsName = String()
        var columns = [NSDictionary]()
        
    }
    
    var Data = [userData]()
    
//    var aBoardNames = [String]()
//    var allColumns = [[NSDictionary]]()
    
    //MARK: - Overridden Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.aBoardNames.removeAll(keepCapacity: true)
        fetchBoards()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UserDetailsTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserDetailsTableViewCell

        cell.aBoardName.text = Data[indexPath.row].boardsName
        
        // Configure the cell...

        return cell
    }
    
    
    //MARK:-My Own Functions
    
    func fetchBoards(){
        
        let aRequest = NSMutableURLRequest(URL: NSURL(string: "http://techiela.com/api/getUserProjects/" + aId)!)
        
        aRequest.HTTPMethod = "GET"
        aRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let aGroup = dispatch_group_create()
        dispatch_group_enter(aGroup)
        
        let aTask = NSURLSession.sharedSession().dataTaskWithRequest(aRequest, completionHandler: { (aData: NSData?,  aResponse: NSURLResponse?, aError: NSError?) -> Void in
            if let aHttpResponse = aResponse as? NSHTTPURLResponse {
                
                if aHttpResponse.statusCode == 200 {
                    
                    self.aResult = (try! NSJSONSerialization.JSONObjectWithData(aData!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                    
                    //print(self.aResult)
                    
                    self.status = self.aResult["status"] as! String
                    self.aData = self.aResult["data"] as! [NSDictionary]
                     var someData = userData()
                    for data in self.aData {
                        
                        someData.boardsName = data["boardName"] as! String
                        let aColumnsResult = data["columns"] as! [NSDictionary]
                        someData.columns = aColumnsResult
                        
                        self.Data.append(someData)
                        
                    }
                    
                }
                dispatch_group_leave(aGroup)
                
                
            } else {
                print(aError?.localizedDescription)
                dispatch_group_leave(aGroup)
            }
          
            for(var i = 0; i < self.Data.count; ++i) {
                
               print(self.Data[i].boardsName)
               print(self.Data[i].columns.count)
                
            }
            
            
        })
        aTask.resume()
        
        dispatch_group_wait(aGroup, DISPATCH_TIME_FOREVER)
        


        
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
