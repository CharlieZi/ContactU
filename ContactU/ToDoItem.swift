//
//  ToDoItem.swift
//  
//
//  Created by HuCharlie on 4/22/15.
//
//

import Foundation
import CoreData



@objc(ToDoItem)
class ToDoItem: NSManagedObject {

    @NSManaged var dueDate: NSDate
    @NSManaged var identifier: String
    @NSManaged var note: String
    @NSManaged var contact: Contact

}
