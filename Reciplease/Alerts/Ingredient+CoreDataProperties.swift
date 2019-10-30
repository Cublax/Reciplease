//
//  Ingredient+CoreDataProperties.swift
//  
//
//  Created by Alexandre Quiblier on 22/10/2019.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var ingredient: String?

}
