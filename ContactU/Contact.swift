//
//  Contact.swift
//  
//
//  Created by HuCharlie on 4/22/15.
//
//

import Foundation
import CoreData



@objc(Contact)
class Contact: NSManagedObject {

    @NSManaged var contactImage: NSData
    @NSManaged var email: String
    @NSManaged var firstName: String
    @NSManaged var identifier: String
    @NSManaged var lastName: String
    @NSManaged var phone: String
    @NSManaged var todoitem: NSSet

}
