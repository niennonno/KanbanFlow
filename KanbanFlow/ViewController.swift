//
//  ViewController.swift
//  KanbanFlow
//
//  Created by Aditya Vikram Godawat on 28/03/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit


var mAccessToken: String!

class ViewController: UIViewController{
    
    var aResult: NSDictionary!
    
  //MARK:- IBAction
    
    @IBAction func mSignInProcess(sender: AnyObject) {
        
        if(aUsernameTextField.text == "" || aPasswordTextField == ""){      //Error Handling
            
            errorLabel.text = "Enter valid Username and Password!"
            
        } else{
        
            //Logging In
            loginFunction()
        
        }
    }
    
  //MARK:- IBOutlets

   
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var aUsernameTextField: HoshiTextField!

    @IBOutlet var aPasswordTextField: HoshiTextField!
    
  //MARK:- Main
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    //MARK:- Overriden Functions
  
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    //MARK:- My own functions
    
    func loginFunction(){
        var flag = false
        var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        let aRequest = NSMutableURLRequest(URL: NSURL(string: "http://techiela.com/api/signIn")!)
        aRequest.HTTPMethod = "POST"
        let loginCred = "email=" + aUsernameTextField.text! + "&password=" + aPasswordTextField.text!
        aRequest.HTTPBody = loginCred.dataUsingEncoding(NSUTF8StringEncoding)
        print(aRequest)
        let aGroup = dispatch_group_create()
        dispatch_group_enter(aGroup)
        let aTask = NSURLSession.sharedSession().dataTaskWithRequest(aRequest, completionHandler: { (aData: NSData?,  aResponse: NSURLResponse?, aError: NSError?) -> Void in
            if let _ = aResponse as? NSHTTPURLResponse {
                print("Success! Got response!")
                //print(aHttpResponse)
                self.aResult = (try! NSJSONSerialization.JSONObjectWithData(aData!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                if self.aResult["status"] as! NSString == "success" {
                    let aData = self.aResult["data"]
                    mAccessToken = aData!["token"] as! String
                    print(mAccessToken)//status check
                    flag = true
                    activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                } else if self.aResult["status"] as! NSString == "fail" {
                    activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    self.errorLabel.text = "Can't log you in!"
                }
                dispatch_group_leave(aGroup)
            } else {
                activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                print(aError?.localizedDescription)
                dispatch_group_leave(aGroup)
            }
        })
        aTask.resume()
        dispatch_group_wait(aGroup, DISPATCH_TIME_FOREVER)
        if flag {
            self.performSegueWithIdentifier("takeMeToAllBoards", sender: self)
        }
    }
    
}