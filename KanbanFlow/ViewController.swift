//
//  ViewController.swift
//  KanbanFlow
//
//  Created by Aditya Vikram Godawat on 28/03/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var aResult: NSDictionary!
    
  //MARK:- IBAction
    
    @IBAction func mSignInProcess(sender: AnyObject) {
        
        self.view.endEditing:YES
        
        if(aUsernameTextField.text == "" || aPasswordTextField == ""){      //Error Handling
            
            alert("Error", message: "Enter Username and Password")
            
        } else{
        
            //Logging In
            loginFunction()
        
        }
    }
    
  //MARK:- IBOutlets

    @IBOutlet var aUsernameTextField: UITextField!
    @IBOutlet var aPasswordTextField: UITextField!
    
  //MARK:- Main
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    //MARK:- Overriden Functions
  
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
 //MARK:- My own functions
    
    
    
    func loginFunction(){
        
        let aRequest = NSMutableURLRequest(URL: NSURL(string: "http://techiela.com/api/signIn")!)
        aRequest.HTTPMethod = "POST"
        
        let loginCred = "email=" + aUsernameTextField.text! + "&password=" + aPasswordTextField.text!
        
        aRequest.HTTPBody = loginCred.dataUsingEncoding(NSUTF8StringEncoding)
//      print(aRequest)
        
        let aGroup = dispatch_group_create()
        dispatch_group_enter(aGroup)
        
        let aTask = NSURLSession.sharedSession().dataTaskWithRequest(aRequest, completionHandler: { (aData: NSData?,  aResponse: NSURLResponse?, aError: NSError?) -> Void in
            
            if let aHttpResponse = aResponse as? NSHTTPURLResponse {
                print("Success! Got response!")
                  print(aHttpResponse)
        
                self.aResult = (try! NSJSONSerialization.JSONObjectWithData(aData!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                
                if self.aResult["status"] as! NSString == "success" {
                    
                    print(self.aResult)
                
                } else if self.aResult["status"] as! NSString == "fail" {
                    
                    self.alert("Error", message: "Can't log you in")
                    
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
    
    func alert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}