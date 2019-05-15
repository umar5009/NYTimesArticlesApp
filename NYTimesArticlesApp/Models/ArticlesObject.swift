//
//  ArticlesObject.swift
//  NYTimesArticlesApp
//
//  Created by Umar Muzaffar Goraya on 5/13/19.
//  Copyright © 2019 Umar Muzaffar Goraya. All rights reserved.
//

import RealmSwift
import Foundation

class ArticlesObject: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var abtract: String!
    @objc dynamic var article_id: String!
    @objc dynamic var adx_keyword: String!
    @objc dynamic var asset_id: String!
    @objc dynamic var byline: String!
    @objc dynamic var column: String!
    var des_facet =  List<String>()
    var geo_facet = List<String>()
    var org_facet = List<String>()
    var per_facet = List<String>()
    @objc dynamic var published_date: String!
    @objc dynamic var section: String!
    @objc dynamic var source: String!
    @objc dynamic var title: String!
    @objc dynamic var type: String!
    @objc dynamic var uri: String!
    @objc dynamic var url: String!
    @objc dynamic var views: String!
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
