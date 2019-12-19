//
//  FavoriteRecipe+CoreDataClass.swift
//  
//
//  Created by Alexandre Quiblier on 31/10/2019.
//
//

import Foundation
import CoreData

@objc(FavoriteRecipe)
public class FavoriteRecipe: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteRecipe> {
        return NSFetchRequest<FavoriteRecipe>(entityName: "FavoriteRecipe")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var servings: String?
    @NSManaged public var source: String?
    @NSManaged public var url: String?
}
