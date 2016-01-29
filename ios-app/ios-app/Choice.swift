//
//  Choice.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import Foundation

class Choice
{
    static let CHOICE_KEY = "choice"
    static let MODIFIERS_KEY = "modifiers"
    
    private(set) var choice: String!
    private(set) var modifiers: [String]!
    
    static func choiceFromDictionary(dictionary: NSDictionary) -> Choice
    {
        let newChoice = Choice()
        
        // parse objects in dictionary
        newChoice.choice = dictionary.objectForKey(CHOICE_KEY) as! String
        newChoice.modifiers = dictionary.objectForKey(MODIFIERS_KEY) as! [String]
        
        return newChoice
    }
}