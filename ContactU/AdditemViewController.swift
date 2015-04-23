//
//  AdditemViewController.swift
//  ContactU
//
//  Created by HuCharlie on 4/22/15.
//  Copyright (c) 2015 HuCharlie. All rights reserved.
//

import UIKit
import CoreData


class AdditemViewController: UIViewController,ContactSelectionDelegate {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var noteTextfield: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var contactImageView: UIImageView!
    
    
    
    var contactIdentifierString:NSString = NSString()
    var datePicked:NSDate = NSDate()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func pickerChanged(sender: UIDatePicker) {
        datePicked = sender.date
    }
    
    @IBAction func DoneBtnClicked(sender: AnyObject) {
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        let predicate:NSPredicate = NSPredicate(format: "identifier == '\(contactIdentifierString)'")
        let results:NSArray = SwiftCoreDataHelper.fetchEntitiesForClass(NSStringFromClass(Contact), withPredicate: predicate, inManagedObjectContext: moc)
        let contact:Contact = results.lastObject as! Contact
        
        var TodoItem:ToDoItem = SwiftCoreDataHelper.insertManagedObjectOfClass(NSStringFromClass(ToDoItem), inManagedObjectContext: moc) as! ToDoItem
        
        TodoItem.identifier = "\(NSDate())"
        TodoItem.dueDate = datePicked
        TodoItem.note = noteTextfield.text
        TodoItem.contact = contact
        
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
        self.navigationController!.popViewControllerAnimated(true)
    }

    
    
    
    
    
    func userDidSelectContact(contactIdentifier: NSString) {
        
        contactIdentifierString = contactIdentifier
        
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        let predicate:NSPredicate = NSPredicate(format: "identifier == '\(contactIdentifier)'")
        let results:NSArray = SwiftCoreDataHelper.fetchEntitiesForClass(NSStringFromClass(Contact), withPredicate: predicate, inManagedObjectContext: moc)
        let contact:Contact = results.lastObject as! Contact
        
        contactImageView.image = UIImage(data:contact.contactImage)
        NameLabel.text = contact.firstName+" "+contact.lastName
        EmailLabel.text = contact.email
        
    }
    

    /*
    // MARK: - Navigation

    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "contactSegue"{
            let ViewController:ContactTableViewController = segue.destinationViewController as! ContactTableViewController
            
            ViewController.delegate = self
        
        }
    }
    
}
