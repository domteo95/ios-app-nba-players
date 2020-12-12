//
//  InjuredList+CoreDataProperties.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 11/11/20.
//
//

import Foundation
import CoreData


extension InjuredList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InjuredList> {
        return NSFetchRequest<InjuredList>(entityName: "InjuredList")
    }

    @NSManaged public var name: String?
    @NSManaged public var injury_date: String?

}

extension InjuredList : Identifiable {

}
