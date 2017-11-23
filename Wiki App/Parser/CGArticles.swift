//
//	CGArticles.swift
//
//	Create by Mayank Gupta on 2/11/2017
//	Copyright © 2017. All rights reserved.
//	

import Foundation

public struct CGArticles{

	var batchcomplete : String!
	var continueField : CGContinue!
	var limits : CGLimit!
	var query : CGQuery!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		batchcomplete = dictionary["batchcomplete"] as? String
		if let continueFieldData = dictionary["continue"] as? NSDictionary{
				continueField = CGContinue(fromDictionary: continueFieldData)
			}
		if let limitsData = dictionary["limits"] as? NSDictionary{
				limits = CGLimit(fromDictionary: limitsData)
			}
		if let queryData = dictionary["query"] as? NSDictionary{
				query = CGQuery(fromDictionary: queryData)
			}
	}

}
