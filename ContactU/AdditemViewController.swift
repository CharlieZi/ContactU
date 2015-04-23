//
//  AdditemViewController.swift
//  ContactU
//
//  Created by HuCharlie on 4/22/15.
//  Copyright (c) 2015 HuCharlie. All rights reserved.
//

import UIKit

class AdditemViewController: UIViewController,ContactSelectionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func DoneBtnClicked(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func userDidSelectContact(contactIdentifier: NSString) {
        println(contactIdentifier)
    }
    

    /*
    // MARK: - Navigation

    */
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "contactSegue"{
//            
//            let ViewController:ContactTableViewController = segue.destinationViewController as! ContactTableViewController
//            
//            ViewController.delegate = self
//        
//        }
    
    
}
