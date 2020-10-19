//
//  Detail+CoreDataProperties.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 17.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//
//

import Foundation
import CoreData


extension Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detail> {
        return NSFetchRequest<Detail>(entityName: "Detail")
    }

    @NSManaged public var image: String
    @NSManaged public var name: String
    @NSManaged public var price: Int32
    @NSManaged public var product_desc: String
    @NSManaged public var product_id: String

}
