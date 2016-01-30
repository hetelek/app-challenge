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
    private(set) var modifiers: [Modifier] = [ ]
    
    static func choiceFromDictionary(dictionary: NSDictionary) -> Choice
    {
        let newChoice = Choice()
        
        // parse objects in dictionary
        newChoice.choice = dictionary.objectForKey(Choice.CHOICE_KEY) as! String
        
        // parse individual modifiers
        let modifiersArray = dictionary.objectForKey(Choice.MODIFIERS_KEY) as! [NSDictionary]
        for modifierDictionary in modifiersArray
        {
            let modifier = Modifier.modifierFromDictionary(modifierDictionary)
            newChoice.modifiers.append(modifier)
        }
        
        return newChoice
    }
}