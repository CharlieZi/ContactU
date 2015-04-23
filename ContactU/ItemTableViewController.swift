//
//  ItemTableViewController.swift
//  ContactU
//
//  Created by HuCharlie on 4/23/15.
//  Copyright (c) 2015 HuCharlie. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class ItemTableViewController: UITableViewController,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {
    
    
    
    var toDoItem:NSMutableArray = NSMutableArray()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
        
        
        
        
        
    }
    
    
    func loadData(){
          toDoItem.removeAllObjects()
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        let results:NSArray = SwiftCoreDataHelper.fetchEntitiesForClass(NSStringFromClass(ToDoItem), withPredicate: nil, inManagedObjectContext: moc)
        
        
        
        if results.count > 0 {
        
            for item in results{
                let singletodoitem:ToDoItem = item as! ToDoItem
                let itemDictionary:NSDictionary = ["identifier":singletodoitem.identifier,"duedate":singletodoitem.dueDate,"note":singletodoitem.note,"firstName":singletodoitem.contact.firstName,"lastName":singletodoitem.contact.lastName,"phone":singletodoitem.contact.phone,"email":singletodoitem.contact.email,"contactImage":singletodoitem.contact.contactImage]
                toDoItem.addObject(itemDictionary)
            
            }
            
            let dateDescriptor:NSSortDescriptor = NSSortDescriptor(key: "duedate", ascending: true)
            var sortedArray:NSArray = toDoItem.sortedArrayUsingDescriptors([dateDescriptor])
            
            toDoItem = NSMutableArray(array: sortedArray)
            
            
            self.tableView.reloadData()
        }

        
    }
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return toDoItem.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ItemTableViewCell = tableView.dequeueReusableCellWithIdentifier("Item", forIndexPath: indexPath) as! ItemTableViewCell

        // Configure the cell...
        
        
        let itemDict:NSDictionary = toDoItem.objectAtIndex(indexPath.row) as! NSDictionary
        
        let firstName = itemDict.objectForKey("firstName") as! String
        let lastName = itemDict.objectForKey("lastName") as! String
        let phone = itemDict.objectForKey("phone") as! String
        let email = itemDict.objectForKey("email") as! String
        let imageData:NSData = itemDict.objectForKey("contactImage") as! NSData
  
        let contactImage:UIImage = UIImage(data: imageData)!
        
        
        let note = itemDict.objectForKey("note")as! String
        
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        let DateString:NSString =  dateFormatter.stringFromDate(itemDict.objectForKey("duedate") as! NSDate)


        
        cell.contactImageView.image = contactImage
        cell.contactName.text = firstName+" "+lastName
        cell.contactNote.text = note
        cell.contactDate.text = DateString as String
        
        
        
        cell.CallBtn.tag = indexPath.row
        cell.TextBtn.tag = indexPath.row
        cell.MailBtn.tag = indexPath.row
        
        cell.CallBtn.addTarget(self, action: "callSomeOne:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.TextBtn.addTarget(self, action: "textSomeOne:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.MailBtn.addTarget(self, action: "mailSomeOne:", forControlEvents: UIControlEvents.TouchUpInside)


        return cell
    }
    
    
    func callSomeOne(sender:UIButton){
        let itemDict:NSDictionary = toDoItem.objectAtIndex(sender.tag)as! NSDictionary
        
        let phoneNumber = itemDict.objectForKey("phone")as! NSString
        
        UIApplication.sharedApplication().openURL(NSURL(string: "telephone://\(phoneNumber)")!)
        
        println("tsetsetsetet")
    }
    
    
    func textSomeOne(sender:UIButton){
        let itemDict:NSDictionary = toDoItem.objectAtIndex(sender.tag)as! NSDictionary
        
        let phoneNumber = itemDict.objectForKey("phone")as! NSString
        
        if MFMessageComposeViewController.canSendText() {
            let messageController:MFMessageComposeViewController = MFMessageComposeViewController()
            messageController.recipients = ["\(phoneNumber)"]
            messageController.messageComposeDelegate = self
            
            self.presentViewController(messageController, animated: true, completion: nil)
        }else{
            println("send failed")
        }
      
    }
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    func mailSomeOne(sender:UIButton){
        let itemDict:NSDictionary = toDoItem.objectAtIndex(sender.tag)as! NSDictionary
        
        let emailAddress = itemDict.objectForKey("email")as! NSString
        
        if MFMailComposeViewController.canSendMail(){
            let mailController:MFMailComposeViewController = MFMailComposeViewController()
            mailController.setToRecipients(["\(emailAddress)"])
            mailController.mailComposeDelegate = self
            
            self.presentViewController(mailController, animated: true, completion: nil)
        }else{
            println("send failed")
        }
        
    }
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }



    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            if (toDoItem.count > 0) {
                let itemDict:NSDictionary = toDoItem.objectAtIndex(indexPath.row)as! NSDictionary
                
                let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
                
                let identifier:NSString = itemDict.objectForKey("identifier")as! NSString
                
                let predicate:NSPredicate = NSPredicate(format: "identifier == '\(identifier)'")
                
                let results:NSArray = SwiftCoreDataHelper.fetchEntitiesForClass(NSStringFromClass(ToDoItem), withPredicate:predicate, inManagedObjectContext: moc)
                
                let todoitemToDlete:ToDoItem = results.lastObject as! ToDoItem
                
                todoitemToDlete.managedObjectContext?.deleteObject(todoitemToDlete)
                
                SwiftCoreDataHelper.saveManagedObjectContext(moc)
                
                loadData()
                self.tableView.reloadData()
                
                
            }
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


}
