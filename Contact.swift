//
//  Contact.swift
//  ContactU
//
//  Created by HuCharlie on 4/21/15.
//  Copyright (c) 2015 HuCharlie. All rights reserved.
//

import Foundation
import CoreData




@objc(Contact)
class Contact: NSManagedObject {

    @NSManaged var identifier: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phone: String
    @NSManaged var email: String
    @NSManaged var contactImage: NSData
    @NSManaged var todoitem: NSSet

}
