//
//  ContactTableViewController.swift
//  ContactU
//
//  Created by HuCharlie on 4/22/15.
//  Copyright (c) 2015 HuCharlie. All rights reserved.
//

import UIKit
import CoreData

protocol ContactSelectionDelegate{
    func userDidSelectContact(contactIdentifier:NSString)
}



class ContactTableViewController: UITableViewController {

    var yourContacts:NSMutableArray = NSMutableArray()
    var delegate:ContactSelectionDelegate? = nil
    
    
    func loadData(){
        //read CoreData
        
        yourContacts.removeAllObjects()
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        let results:NSArray = SwiftCoreDataHelper.fetchEntitiesForClass(NSStringFromClass(Contact), withPredicate: nil, inManagedObjectContext: moc)
        
        
        for contact in results{
            let singleContact:Contact = contact as! Contact
            let contactDictionary:NSDictionary = ["identifier":singleContact.identifier,"firstName":singleContact.firstName,"lastName":singleContact.lastName,"phone":singleContact.phone,"email":singleContact.email,"contactImage":singleContact.contactImage]
            yourContacts.addObject(contactDictionary)
           
        }
         self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
        
        

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return yourContacts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ContactCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ContactCellTableViewCell

        // Configure the cell...
        
        let contactDict:NSDictionary = yourContacts.objectAtIndex(indexPath.row) as! NSDictionary
        
        let firstName = contactDict.objectForKey("firstName") as! String
        let lastName = contactDict.objectForKey("lastName") as! String
        let phone = contactDict.objectForKey("phone") as! String
        let email = contactDict.objectForKey("email") as! String
        let imageData:NSData = contactDict.objectForKey("contactImage") as! NSData
        
        let contactImage:UIImage = UIImage(data: imageData)!
        
        
        //define label
        
        cell.contactName.text = firstName + " "+lastName
        cell.contactPhone.text = phone
        cell.contactEmail.text = email
        

        
        
        
        
        var contactImageFrame:CGRect = cell.contactImage.frame
        
        contactImageFrame.size = CGSize(width: 75, height: 75)
        
        cell.contactImage.frame = contactImageFrame
        cell.contactImage.image = contactImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        if (delegate != nil) {
            let contactDict:NSDictionary = yourContacts.objectAtIndex(indexPath.row) as! NSDictionary
            
            delegate!.userDidSelectContact(contactDict.objectForKey("identifier") as! NSString)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    
    
}



















