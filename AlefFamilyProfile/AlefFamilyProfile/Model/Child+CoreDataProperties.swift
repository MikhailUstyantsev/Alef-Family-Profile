//
//  Child+CoreDataProperties.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//
//

import Foundation
import CoreData


extension Child {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Child> {
        return NSFetchRequest<Child>(entityName: "Child")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var parent: Parent?

}

extension Child : Identifiable {

}
