//
//  Book+CoreDataProperties.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/8/24.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var price: String?

}

extension Book : Identifiable {

}
