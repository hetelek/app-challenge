//
//  Game.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import Foundation

class Game
{
    static let sharedInstance = Game()
    
    private(set) var choices: [Choice] = [ ]
    private(set) var selectedChoice: Choice!
    {
        didSet
        {
            self.selectedModifier = nil
        }
    }
    private(set) var selectedModifier: Modifier!
    
    init()
    {
        // read choices from plist
        let choicesArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("Choices", ofType: "plist")!) as! [NSDictionary]
        
        // parse choices, add to array
        for choiceDictionary in choicesArray
        {
            let choice = Choice.choiceFromDictionary(choiceDictionary)
            self.choices.append(choice)
        }
    }
    
    func randomChoices() -> [Choice]
    {
        // return the array if we don't have sufficient choices
        if self.choices.count <= 4
        {
            return self.choices
        }
        
        // generate random choices
        var randomArray: [Choice] = [ ]
        repeat
        {
            // get a random choice
            let randomChoice = self.choices[Int.random(min: 0, max: self.choices.count - 1)]
            
            // see if our array contains it
            var alreadyAddedChoice = false
            for alreadyChosen in randomArray
            {
                if randomChoice === alreadyChosen
                {
                    alreadyAddedChoice = true
                    break
                }
            }
            
            // if not, add it
            if !alreadyAddedChoice
            {
                randomArray.append(randomChoice)
            }
        }
        while randomArray.count < 4
        
        return randomArray
    }
    
    func selectChoice(choice: Choice)
    {
        self.selectedChoice = choice
    }

    func selectModifier(modifier: Modifier)
    {
        assert(self.selectedChoice != nil)
        
        self.selectedModifier = modifier
    }
}