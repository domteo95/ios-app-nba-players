//
//  FavList+CoreDataProperties.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 11/11/20.
//
//

import Foundation
import CoreData


extension FavList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavList> {
        return NSFetchRequest<FavList>(entityName: "FavList")
    }

    @NSManaged public var name: String?
    @NSManaged public var team_name: String?
    @NSManaged public var assists: String?
    @NSManaged public var blocks: String?
    @NSManaged public var minutes: String?
    @NSManaged public var image: String?
    @NSManaged public var points: String?
    @NSManaged public var rebounds: String?
    @NSManaged public var steals: String?
    @NSManaged public var per: String?

}

extension FavList : Identifiable {

}
