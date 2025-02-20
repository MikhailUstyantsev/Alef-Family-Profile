//
//  Child+CoreDataProperties.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 21.02.2025.
//
//

import Foundation
import CoreData


extension Child {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Child> {
        return NSFetchRequest<Child>(entityName: "Child")
    }

    @NSManaged public var age: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var parents: NSSet?

}

// MARK: Generated accessors for parents
extension Child {

    @objc(addParentsObject:)
    @NSManaged public func addToParents(_ value: Parent)

    @objc(removeParentsObject:)
    @NSManaged public func removeFromParents(_ value: Parent)

    @objc(addParents:)
    @NSManaged public func addToParents(_ values: NSSet)

    @objc(removeParents:)
    @NSManaged public func removeFromParents(_ values: NSSet)

}

extension Child : Identifiable {

}
