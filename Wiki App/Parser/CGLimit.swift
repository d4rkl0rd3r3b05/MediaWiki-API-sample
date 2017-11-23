//
//	CGLimit.swift
//
//	Create by Mayank Gupta on 2/11/2017
//	Copyright © 2017. All rights reserved.
//	

import Foundation

public struct CGLimit{

	var extracts : Int!
	var pageimages : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		extracts = dictionary["extracts"] as? Int
		pageimages = dictionary["pageimages"] as? Int
	}

}
