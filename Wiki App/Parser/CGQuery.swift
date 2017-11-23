//
//	CGQuery.swift
//
//	Create by Mayank Gupta on 2/11/2017
//	Copyright © 2017. All rights reserved.
//	

import Foundation

public struct CGQuery{

    var pages : [String : CGPage]?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let pagesData = dictionary["pages"] as? NSDictionary{
            pages = [String : CGPage]()
            for (key, value) in pagesData {
                pages![key as! String] = CGPage(fromDictionary: value as! NSDictionary)
            }
        }
	}

}
