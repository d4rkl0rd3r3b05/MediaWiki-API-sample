//
//	CGPage.swift
//
//	Create by Mayank Gupta on 2/11/2017
//	Copyright © 2017. All rights reserved.
//	

import Foundation

public struct CGPage{
    var extract : String!
    var index : Int!
    var ns : Int!
    var pageid : Int!
    var title : String!
    var thumbnail : CGThumbnail!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        extract = dictionary["extract"] as? String
        index = dictionary["index"] as? Int
        ns = dictionary["ns"] as? Int
        pageid = dictionary["pageid"] as? Int
        title = dictionary["title"] as? String
        if let thumbnailData = dictionary["thumbnail"] as? NSDictionary{
            thumbnail = CGThumbnail(fromDictionary: thumbnailData)
        }
    }
}
