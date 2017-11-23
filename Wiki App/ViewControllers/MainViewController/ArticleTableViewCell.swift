//
//  ArticleTableViewCell.swift
//  Wiki App
//
//  Created by Mayank Gupta on 04/11/17.
//  Copyright © 2017 Mayank Gupta. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticleTableViewCell: UITableViewCell {
    //MARK: - Instance Variables
    var associatedArticle : CGPage?
    
    //MARK: - IBOutlets
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleSubtitle: UILabel!
    
    //MARK: - Cell Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - Data Initialization Methods
    func setCellData(article : CGPage) {
        self.associatedArticle = article
        self.articleTitle.text = !article.title.isEmpty ? article.title : ""
        self.articleSubtitle.text = !article.extract.isEmpty ? article.extract : ""
        if article.thumbnail?.source != nil {
            self.articleImage.af_setImage(
                withURL: URL(string: article.thumbnail.source)!
            )
        }else{
            self.articleImage.image = nil
        }
    }
}
