//
//  MetaDataObject.swift
//  NYTimesArticlesApp
//
//  Created by Umar Muzaffar Goraya on 5/13/19.
//  Copyright © 2019 Umar Muzaffar Goraya. All rights reserved.
//

import RealmSwift
import Foundation
import UIKit

class MetaDataObject: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var format: String!
    @objc dynamic var height: String!
    @objc dynamic var url: String!
    @objc dynamic var width: String!
    @objc dynamic var article_id: String!
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

