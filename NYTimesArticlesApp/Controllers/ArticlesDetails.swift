//
//  ArticlesDetails.swift
//  NYTimesArticlesApp
//
//  Created by Umar Muzaffar Goraya on 5/13/19.
//  Copyright © 2019 Umar Muzaffar Goraya. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage
import Alamofire

class ArticlesDetails: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let realm = try! Realm()
    
    var titleStr: String!
    var abstractStr: String!
    var secStr: String!
    var sourceStr: String!
    var indexNumber: String!
    var authorNameStr: String!
    var publishedDateStr: String!
    
    @IBOutlet var authorName: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var publishedDate: UILabel!
    @IBOutlet var section: UILabel!
    @IBOutlet var source: UILabel!
    @IBOutlet var abstract: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var shadowView: UIView!
    
    var metaDataObject: Results<MetaDataObject> {
        get {
            print(indexNumber)
            let predicate = NSPredicate(format: "article_id = %@", indexNumber)
            return realm.objects(MetaDataObject.self).filter(predicate)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.layer.cornerRadius = 15
        shadowView.layer.cornerRadius = 15

        titleLabel.text = titleStr
        authorName.text = authorNameStr
        section.text = secStr
        publishedDate.text = publishedDateStr
        abstract.text = abstractStr
        source.text = sourceStr
        
        scrollView.contentSize  = CGSize(width: 0, height: 1200)
    }
    
    @IBAction func cancelBtnAction(sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return metaDataObject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticlesSubImagesCell", for: indexPath) as! ArticlesSubImagesCell
        
        let getImgPath = metaDataObject[indexPath.row]
        let newPath = getImgPath.url
        let remoteImageURL = URL(string: newPath!)!
        
        Alamofire.request(remoteImageURL).responseData { (response) in
            if response.error == nil {
                print(response.result)
                
                // Show the downloaded image:
                if let data = response.data {
                    
                    let image = UIImage(data: data)
                    cell.imageView.image = image
                }
            }
        }
        return cell
    }
}
