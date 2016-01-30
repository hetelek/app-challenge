//
//  Modifier.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/30/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import Foundation

class Modifier
{
    static let FULL_TEXT_KEY = "full_text"
    static let MODIFIER_ONLY_KEY = "modifier_only"
    
    private(set) var modifierOnly: String!
    private(set) var fullText: String!
    
    static func modifierFromDictionary(dictionary: NSDictionary) -> Modifier
    {
        let newModifier = Modifier()
        
        // parse objects in dictionary
        newModifier.fullText = dictionary.objectForKey(Modifier.FULL_TEXT_KEY) as! String
        newModifier.modifierOnly = dictionary.objectForKey(Modifier.MODIFIER_ONLY_KEY) as! String
        
        return newModifier
    }
}