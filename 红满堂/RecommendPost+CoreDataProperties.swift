//
//  RecommendPost+CoreDataProperties.swift
//  红满堂
//
//  Created by Jacko Qm on 04/03/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import Foundation
import CoreData


extension RecommendPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecommendPost> {
        return NSFetchRequest<RecommendPost>(entityName: "RecommendPost");
    }

    @NSManaged public var answerCount: String?
    @NSManaged public var authorID: String?
    @NSManaged public var postDate: String?
    @NSManaged public var previewText: String?
    @NSManaged public var serialNum: Int16
    @NSManaged public var threadID: String?
    @NSManaged public var title: String?
    @NSManaged public var userName: String?
    @NSManaged public var lastEdit: String?

}
