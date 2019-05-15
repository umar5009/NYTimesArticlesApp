//
//  Media.swift
//  NYTimesArticlesApp
//
//  Created by Umar Muzaffar Goraya on 5/13/19.
//  Copyright © 2019 Umar Muzaffar Goraya. All rights reserved.
//

import RealmSwift
import Foundation
import UIKit

class ArtcilesMediaObject: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var approved_for_syndication: String!
    @objc dynamic var caption: String!
    @objc dynamic var copyright: String!
    @objc dynamic var subtype: String!
    @objc dynamic var type: String!
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
