//
//	CGThumbnail.swift
//
//	Create by Mayank Gupta on 2/11/2017
//	Copyright © 2017. All rights reserved.
//	

import Foundation

public struct CGThumbnail{

	var height : Int!
	var source : String!
	var width : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		height = dictionary["height"] as? Int
		source = dictionary["source"] as? String
		width = dictionary["width"] as? Int
	}

}
