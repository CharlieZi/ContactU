//
//  AddContactTableViewController.swift
//  ContactU
//
//  Created by HuCharlie on 4/21/15.
//  Copyright (c) 2015 HuCharlie. All rights reserved.
//

import UIKit
import CoreData



class AddContactTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    @IBOutlet weak var firstNameTextfield: UITextField!
    
    @IBOutlet weak var lastNameTextfield: UITextField!
    
    @IBOutlet weak var phoneTextfield: UITextField!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var contactImageView: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //choose image trigger
        
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "chooseImage:")
        tapGestureRecognizer.numberOfTapsRequired = 1
        contactImageView.addGestureRecognizer(tapGestureRecognizer)
        contactImageView.userInteractionEnabled = true

    }
    
    
//imgae picker
    func chooseImage(recognizer:UITapGestureRecognizer) {
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true  , completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {

        let pickedImage:UIImage = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
            
        let smallPicture = scaleImageWidth(pickedImage, newSize: CGSizeMake(100, 100))
        
        var sizeOfImageView:CGRect =  contactImageView.frame
        sizeOfImageView.size = smallPicture.size
        contactImageView.frame = sizeOfImageView
        contactImageView.image = smallPicture
        
        picker.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func scaleImageWidth(image:UIImage,newSize:CGSize)->UIImage{
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage
        
    
    }
    
    // done button clicked
    
    
    
    
    @IBAction func addContactDoneBtnClicked(sender: AnyObject) {
        
        
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        var contact:Contact = SwiftCoreDataHelper.insertManagedObjectOfClass(NSStringFromClass(Contact), inManagedObjectContext: moc) as! Contact

        
        contact.identifier = "\(NSDate())"
        contact.firstName = firstNameTextfield.text
        contact.lastName = lastNameTextfield.text
        contact.phone = phoneTextfield.text
        contact.email = emailTextfield.text
        
        let contactImageData:NSData = UIImagePNGRepresentation(contactImageView.image)
        
        contact.contactImage = contactImageData
        
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
        self.navigationController?.popViewControllerAnimated(true)
        
        
        
        
    }



    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
}
