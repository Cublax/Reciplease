//
//  Recipe+CoreDataProperties.swift
//  
//
//  Created by Alexandre Quiblier on 31/10/2019.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var name: String?
    @NSManaged public var source: String?
    @NSManaged public var url: String?
    @NSManaged public var servings: String?

}
