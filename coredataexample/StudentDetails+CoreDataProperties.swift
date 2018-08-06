//
//  StudentDetails+CoreDataProperties.swift
//  coredataexample
//
//  Created by Elluminati Mac Mini 1 on 05/04/18.
//  Copyright © 2018 Example. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension StudentDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentDetails> {
        return NSFetchRequest<StudentDetails>(entityName: "StudentDetails");
    }

    @NSManaged public var studentName: String?
    @NSManaged public var studentMark: String?

}
