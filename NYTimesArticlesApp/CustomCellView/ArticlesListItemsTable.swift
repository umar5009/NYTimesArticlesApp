//
//  ArticlesTableCell.swift
//  NYTimesArticlesApp
//
//  Created by Umar Muzaffar Goraya on 5/13/19.
//  Copyright © 2019 Umar Muzaffar Goraya. All rights reserved.
//

import Foundation
import UIKit

class ArticlesListItemsTable: UITableViewCell
{
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleAuthor: UILabel!
    @IBOutlet var publishedDate: UILabel!
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var shadowView: UIView!
}
