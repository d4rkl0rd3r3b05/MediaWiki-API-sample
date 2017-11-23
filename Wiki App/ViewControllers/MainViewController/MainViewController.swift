//
//  MainViewController.swift
//  Wiki App
//
//  Created by Mayank Gupta on 04/11/17.
//  Copyright © 2017 Mayank Gupta. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    //MARK: - Instance Variables
    var searchText : String?
    var searchResponse : NSDictionary?
    var articles : [CGPage]?
    var recentSearches : [Recent]?
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var recentSearchCollection: UICollectionView!
    
    //MARK: - View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        recentSearches = CoreDataHandler.sharedInstance.getItemsInEntity("Recent", withSortDescriptorKey: "searchTime") as? [Recent]
        fetchArticles(searchText: "")
    }

    //MARK: - Click Action
    @IBAction func saveAction(_ sender: Any) {
        guard searchResponse != nil && searchText != nil && searchText!.count >= MINIMUM_CHARACTER_FOR_SUGGESTION else {
            return
        }
            
        Recent.saveToRecent(searchText: searchText!, response: NSKeyedArchiver.archivedData(withRootObject: searchResponse!))
        
        //Reload Recent Collection
        recentSearches = CoreDataHandler.sharedInstance.getItemsInEntity("Recent", withSortDescriptorKey: "searchTime") as? [Recent]
        recentSearchCollection.reloadData()
    }
    
    //MARK: - Table View Data Source and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.articles != nil && self.articles!.count > 0 {
            self.articleTableView.isHidden = false
            return self.articles!.count
        }
        
        self.articleTableView.isHidden = true
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        cell.setCellData(article:  self.articles![indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.associatedURL = "https://en.wikipedia.org/wiki?curid="+String(self.articles![indexPath.row].pageid)
        
        self.present(UINavigationController(rootViewController: detailViewController), animated: true, completion: nil)
    }
    
    //MARK: - Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count >= MINIMUM_CHARACTER_FOR_SUGGESTION {
            fetchArticles(searchText: searchText)
        }else{
            //Cancelling the previous request
            Alamofire.SessionManager.default.session.getAllTasks { task in
                task.forEach { $0.cancel() }
            }
            
            self.articles = nil
            self.searchResponse = nil
            self.searchText = nil
            self.articleTableView.reloadData()
        }
    }
    
    //MARK: - API Calls
    func fetchArticles(searchText : String) {
        //Cancelling the previous request
        Alamofire.SessionManager.default.session.getAllTasks { task in
            task.forEach { $0.cancel() }
        }
        
        Alamofire.request(
            URL(string: ARTICLE_URL)!,
            method: .get,
            parameters: ["gsrsearch": searchText, "prop": "pageimages|extracts"])
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching articles for search text: \(response.result.error?.localizedDescription ?? "Undefined")")
                    return
                }
                
                guard let response = response.result.value as? NSDictionary else{
                        print("Malformed data received from fetch article service")
                        return
                }
                
                self.searchText = nil
                self.searchText = searchText
                self.searchResponse = nil
                self.searchResponse = response
                
                let responseData = CGArticles(fromDictionary: response)
                
                if responseData.query?.pages != nil && (responseData.query.pages?.keys)!.count > 0 {
                    
                    self.articles = responseData.query.pages?.values.map{$0}
                    self.articleTableView.reloadData()
                }
        }
    }
}

