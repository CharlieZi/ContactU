//
//  ToDoitem.swift
//  ContactU
//
//  Created by HuCharlie on 4/21/15.
//  Copyright (c) 2015 HuCharlie. All rights reserved.
//

import Foundation
import CoreData



@objc(Todoitem)
class ToDoitem: NSManagedObject {

    @NSManaged var identifier: String
    @NSManaged var dueDate: String
    @NSManaged var note: String
    @NSManaged var contact: Contact

}
