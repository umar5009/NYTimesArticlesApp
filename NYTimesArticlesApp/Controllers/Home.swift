//
//  ViewController.swift
//  NYTimesArticlesApp
//
//  Created by Umar Muzaffar Goraya on 5/13/19.
//  Copyright © 2019 Umar Muzaffar Goraya. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage
import Alamofire

class Home: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var status: String!
    let realm = try! Realm()
    var indexNumber: String!
    
    var articlesObject: Results<ArticlesObject> {
        get {
            return realm.objects(ArticlesObject.self)
        }
    }
    
    var metaDataObject: Results<MetaDataObject> {
        get {
            let predicate = NSPredicate(format: "article_id = %@", indexNumber)
            return realm.objects(MetaDataObject.self).filter(predicate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiCalledOnce = defaults.bool(forKey: "apiCalledOnce")
        
        if apiCalledOnce == false
        {
            apiCalledOnce = true
            defaults.set(apiCalledOnce, forKey: "apiCalledOnce")
            
            getArticlesDataFromAP()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesObject.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesListItemsTable", for: indexPath) as! ArticlesListItemsTable
        
         cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
         cell.shadowView.layer.cornerRadius = 15
         cell.articleImage?.layer.masksToBounds = true
         cell.articleImage?.layer.masksToBounds = false
         cell.articleImage?.layer.cornerRadius = (cell.articleImage?.frame.height)!/2
         cell.articleImage?.clipsToBounds = true
        
         cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
         let getListItems = articlesObject[indexPath.row]
         indexNumber = getListItems.article_id
        
         let getImages = metaDataObject[0]
        
         cell.articleTitle.text = getListItems.title
         cell.articleAuthor.text  = getListItems.byline
         cell.publishedDate.text = getListItems.published_date
        
         let remoteImageURL = URL(string: getImages.url!)!
        
         Alamofire.request(remoteImageURL).responseData { (response) in
            if response.error == nil {
                print(response.result)
                
                // Show the downloaded image:
                if let data = response.data {
                    
                    let image = UIImage(data: data)
                    cell.articleImage!.image = image
                }
            }
         }
        
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let getParticularItem = articlesObject[indexPath.row]
    
        if let showPopUpDetails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticlesDetails") as? ArticlesDetails {
            
                    showPopUpDetails.titleStr = getParticularItem.title
                    showPopUpDetails.abstractStr = getParticularItem.abtract
                    showPopUpDetails.sourceStr = getParticularItem.source
                    showPopUpDetails.secStr = getParticularItem.section
                    showPopUpDetails.publishedDateStr = getParticularItem.published_date
                    showPopUpDetails.authorNameStr = getParticularItem.byline
                    showPopUpDetails.indexNumber = getParticularItem.article_id
            
                    self.present(showPopUpDetails, animated: true, completion: nil)
        }
    }

    func getArticlesDataFromAP()
    {
        startActivityIndicator("")
        
        let url = URL(string:  urlLink)!
        
        //let header:HTTPHeaders = ["api-key" : "j7pRJV1jp1IggounblnobvMeAxFbIdz"]
        
        //let body : [String: Any] = ["period": "7"]
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response  in
            
                switch response.result {
                
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                
                do {
                    
                    try! self.realm.write ({
                        if let array = JSON as? NSObject{
                            if let dict = array as? NSDictionary {
                                
                                let status = dict.value(forKey: "status") as! String

                                if status == "OK"
                                {
                                    stopActivityIndicator()
                                    
                                    let results = dict.value(forKey: "results")
                                    if let array = results as? NSArray{
                                        for obj in array {
                                            if let dict = obj as? NSDictionary {
                                                
                                                let abtract = dict.value(forKey: "abstract") as? String
                                                let adx_keyword = dict.value(forKey: "adx_keyword") as? String
                                                let asset_id = dict.value(forKey:"asset_id") as? String
                                                let byline = dict.value(forKey:"byline") as? String
                                                let column = dict.value(forKey:"column") as? String
//                                                let des_facet = dict.value(forKey:"des_facet") as? String
//                                                let geo_facet = dict.value(forKey:"geo_facet") as? String
//                                                let org_facet = dict.value(forKey:"org_facet") as? String
//                                                let per_facet = dict.value(forKey:"per_facet") as? String
                                                let published_date = dict.value(forKey:"published_date") as? String
                                                let section = dict.value(forKey:"section") as? String
                                                let source = dict.value(forKey:"source") as? String
                                                let title = dict.value(forKey:"title") as? String
                                                let type = dict.value(forKey:"type") as? String
                                                let uri = dict.value(forKey:"uri") as? String
                                                let url = dict.value(forKey:"url") as? String
                                                let views = dict.value(forKey:"views") as? String
                                                let article_id: Int = (dict.value(forKey:"id") as? Int)!
                                                
                                                print(article_id)
                                                let media = dict.value(forKey:"media")
                                                
                                                if let array = media as? NSArray{
                                                    for obj in array {
                                                        if let dict = obj as? NSDictionary {
                                                            
                                                            let approved_for_syndication = dict.value(forKey:"approved_for_syndication") as? String
                                                            let caption = dict.value(forKey:"caption") as? String
                                                            let copyright = dict.value(forKey:"copyright") as? String
                                                            let type = dict.value(forKey:"type") as? String
                                                            let subtype = dict.value(forKey:"subtype") as? String
                                                            
                                                            let media_metadata = dict.value(forKey:"media-metadata")
                                                            
                                                            if let array = media_metadata as? NSArray{
                                                                for obj in array {
                                                                    if let dict = obj as? NSDictionary {
                                                                        
                                                                        let format = dict.value(forKey:"format") as? String
                                                                        let height = dict.value(forKey:"height") as? String
                                                                        let url = dict.value(forKey:"url") as? String
                                                                        let width = dict.value(forKey:"width") as? String
                                                                        
                                                                        let metaDataObj = MetaDataObject()
                                                                        
                                                                        metaDataObj.format = format
                                                                        metaDataObj.height = height
                                                                        metaDataObj.url = url
                                                                        metaDataObj.width = width
                                                                        metaDataObj.article_id = String(article_id)
                                                                        metaDataObj.id = self.primaryKeyMetaDataObj()
                                                                        
                                                                        self.realm.add(metaDataObj)
                                                                    }
                                                                }
                                                            }
                                                            
                                                            let artcilesMediaObj = ArtcilesMediaObject()
                                                            
                                                            artcilesMediaObj.approved_for_syndication = approved_for_syndication
                                                            artcilesMediaObj.caption = caption
                                                            artcilesMediaObj.copyright = copyright
                                                            artcilesMediaObj.type = type
                                                            artcilesMediaObj.subtype = subtype
                                                            artcilesMediaObj.id = self.primaryKeyArticlesMediaObj()
                                                            
                                                            self.realm.add(artcilesMediaObj)
                                                        }
                                                    }
                                                }
                                                
                                                let articlesObj = ArticlesObject()
                                                
                                                articlesObj.abtract = abtract
                                                articlesObj.adx_keyword = adx_keyword
                                                articlesObj.asset_id = asset_id
                                                articlesObj.byline = byline
                                                articlesObj.column = column
//                                                 print(des_facet)
//                                                 print(geo_facet)
//                                                 print(org_facet)
//                                                 print(per_facet)
//                                                articlesObj.des_facet.append(des_facet!)
//                                                articlesObj.geo_facet.append(geo_facet!)
//                                                articlesObj.org_facet.append(org_facet!)
//                                                articlesObj.per_facet.append(per_facet!)
                                                articlesObj.published_date = published_date
                                                articlesObj.section = section
                                                articlesObj.source = source
                                                articlesObj.title = title
                                                articlesObj.type = type
                                                articlesObj.uri = uri
                                                articlesObj.url = url
                                                articlesObj.views = views
                                                articlesObj.article_id = String(article_id)
                                                articlesObj.id = self.primaryKeyArticlesObj()
                                            
                                                self.realm.add(articlesObj)

                                            }
                                        }
                                    }
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    })
                }
                catch let error as NSError {
                    //TODO: Handle error
                }
                break
                
            case .failure(_):
                print(response.result.error!)
                
                break
            }
        }
     }
    func primaryKeyMetaDataObj() -> Int
    {
        return (realm.objects(MetaDataObject.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    func primaryKeyArticlesMediaObj() -> Int
    {
        return (realm.objects(ArtcilesMediaObject.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    func primaryKeyArticlesObj() -> Int
    {
        return (realm.objects(ArticlesObject.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}

