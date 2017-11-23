//
//  RecentContainer.swift
//  Wiki App
//
//  Created by Mayank Gupta on 04/11/17.
//  Copyright © 2017 Mayank Gupta. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: UICollectionViewDataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentSearches?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell", for: indexPath) as! RecentCell
        cell.searchText.text = recentSearches![indexPath.row].searchText
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSearch = recentSearches![indexPath.row]
        
        self.searchText = nil
        self.searchText = selectedSearch.searchText
        self.searchBar.text = selectedSearch.searchText
        self.searchResponse = nil
        self.searchResponse = NSKeyedUnarchiver.unarchiveObject(with: selectedSearch.response!) as? NSDictionary
        guard self.searchResponse != nil else {
            return
        }
        
        let responseData = CGArticles(fromDictionary: self.searchResponse!)
        
        if responseData.query?.pages != nil && (responseData.query.pages?.keys)!.count > 0 {
            
            self.articles = responseData.query.pages?.values.map{$0}
            self.articleTableView.reloadData()
        }
    }
}

class RecentCell : UICollectionViewCell {
    @IBOutlet weak var searchText: UILabel!
}
