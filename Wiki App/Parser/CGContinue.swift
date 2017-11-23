//
//	CGContinue.swift
//
//	Create by Mayank Gupta on 2/11/2017
//	Copyright © 2017. All rights reserved.
//	

import Foundation

public struct CGContinue{

	var continueField : String!
	var gsroffset : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		continueField = dictionary["continue"] as? String
		gsroffset = dictionary["gsroffset"] as? Int
	}

}
