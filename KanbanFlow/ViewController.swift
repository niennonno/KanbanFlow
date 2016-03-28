//
//  ViewController.swift
//  KanbanFlow
//
//  Created by Aditya Vikram Godawat on 28/03/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    
    
    
  //MARK:- IBOutlets

    @IBOutlet var aUsernameTextField: UITextField!
    @IBOutlet var aPasswordTextField: UITextField!

    
    
  //MARK:- Main
    override func viewDidLoad() {
        super.viewDidLoad()

//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)

        
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
    
//    func keyboardWillShow(notification: NSNotification) {
//        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y -= keyboardSize.height
//        }
//        
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y += keyboardSize.height
//        }
//    }
}