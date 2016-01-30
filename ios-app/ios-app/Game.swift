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
    private(set) var roundTime: NSTimeInterval = 10
    
    // team
    private(set) var teams: [Team] = [ Team(teamColor: .Yellow), Team(teamColor: .Blue) ]
    private(set) var guessingTeam: Team
    
    // timer
    private(set) var timer: NSTimer?
    private var canCurrentlyAnswer: Bool
    {
        get
        {
            // if the timer is going to fire in the future, then they can guess
            if let timer = self.timer
            {
                return timer.fireDate.compare(NSDate()) == .OrderedAscending
            }
            
            return false
        }
    }
    
    // game state
    private(set) var choices: [Choice] = [ ]
    private(set) var selectedChoice: Choice!
    {
        didSet
        {
            self.selectedModifier = nil
        }
    }
    private(set) var selectedModifier: Modifier!
    
    // other
    private var target: AnyObject?
    private var selector: Selector?
    
    init()
    {
        // set guessing team
        self.guessingTeam = self.teams[0]
        
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
    
    func startTimer(target: AnyObject?, selector: Selector)
    {
        // stop the timer if it's already running
        self.timer?.invalidate()
        
        // set variables
        self.target = target
        self.selector = selector
        
        // start timer
        self.timer = NSTimer.scheduledTimerWithTimeInterval(self.roundTime, target: self, selector: "timerFired:", userInfo: nil, repeats: false)
    }
    
    @objc func timerFired(timer: NSTimer)
    {
        // null timer out
        self.timer = nil
        
        // perform selector
        if let selector = self.selector
        {
            self.target?.performSelector(selector)
        }
    }
    
    func answeredCorrectly()
    {
        // if they can't answer right now, just return
        if !self.canCurrentlyAnswer
        {
            return
        }
        
        // stop the timer
        self.timer?.invalidate()
        self.timer = nil
        
        // give the guessing team a point
        ++self.guessingTeam.score
        
        // change guessing team
        if self.guessingTeam.teamColor == .Yellow
        {
            self.guessingTeam = self.teams[1]
        }
        else
        {
            self.guessingTeam = self.teams[0]
        }
    }
    
    func selectChoice(choice: Choice)
    {
        self.selectedChoice = choice
        self.selectedModifier = nil
    }

    func selectModifier(modifier: Modifier)
    {
        assert(self.selectedChoice != nil)
        self.selectedModifier = modifier
    }
}