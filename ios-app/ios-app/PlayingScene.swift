//
//  PlayingScene.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class PlayingScene : SKScene, CommunicatorDelegate
{
    var contentCreated = false
    var bar1: SKSpriteNode!
    var bar2: SKSpriteNode!
    var bar3: SKSpriteNode!
    var bar4: SKSpriteNode!
    var bar5: SKSpriteNode!
    
    var roundTime: NSTimeInterval!
    let TIMER_BAR_WIDTH: CGFloat = 17
    var GOT_IT_SIZE: CGSize!
    var TAP_TO_VIEW_SIZE: CGSize!
    let PADDING_FROM_CENTER: CGFloat = 0
    
    override func didMoveToView(view: SKView)
    {
        // set round time
        self.roundTime = Game.sharedInstance.roundTime
        
        // setup communicator
        Communicator.sharedInstance.delegate = self
        Communicator.sharedInstance.sendData(.Playing, data: [ "roundTime": self.roundTime, "blueTeam": Game.sharedInstance.guessingTeam.teamColor == TeamColor.Blue ])
        
        // create the content if we haven't already
        if !self.contentCreated
        {
            self.createContent()
            self.contentCreated = true
        }
    }
    
    private func createContent()
    {
        // set background color/scale
        self.scaleMode = .ResizeFill
        
        // screen center
        let centerX = CGRectGetMidX(self.frame)
        let centerY = CGRectGetMidY(self.frame)
        
        // calculate sizes
        self.GOT_IT_SIZE = CGSize(width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame) / 2)
        self.TAP_TO_VIEW_SIZE = CGSize(width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame) / 2)
        
        // create got it button
        let gotItButton = CoolButton(color: SKColor.gameYellowColor(), size: self.GOT_IT_SIZE)
        gotItButton.text = "Guessed Correctly"
        gotItButton.fontColor = SKColor.gameBlueColor()
        gotItButton.label.fontSize = 96
        gotItButton.position = CGPoint(x: centerX, y: centerY - (self.GOT_IT_SIZE.height + self.PADDING_FROM_CENTER) / 2)
        gotItButton.addTarget(self, selector: "gotItButtonTapped:")
        
        self.addChild(gotItButton)
        
        // create instructions pane
        let instructionsPane = TapToViewPane(color: SKColor.gameBlueColor(), size: self.TAP_TO_VIEW_SIZE)
        instructionsPane.unhiddenText = "Tap and Hold to View Instructions"
        instructionsPane.fontColor = SKColor.gameYellowColor()
        instructionsPane.label.fontName = "Raleway-Bold"
        instructionsPane.hiddenText = Game.sharedInstance.selectedModifier.fullText
        instructionsPane.position = CGPoint(x: centerX, y: centerY + (self.GOT_IT_SIZE.height + self.PADDING_FROM_CENTER) / 2)
        
        self.addChild(instructionsPane)
        
        makeEmptyBars()
        
        // top bar (starting centered)
        self.bar1 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: self.TIMER_BAR_WIDTH))
        self.bar1.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar1)
        
        // right bar
        self.bar2 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: self.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame)))
        self.bar2.anchorPoint = CGPoint(x: 1, y: 1)
        self.bar2.position = CGPoint(x: CGRectGetWidth(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar2)
        
        // bottom bar
        self.bar3 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame), height: self.TIMER_BAR_WIDTH))
        self.bar3.anchorPoint = CGPoint(x: 1, y: 0)
        self.bar3.position = CGPoint(x: CGRectGetWidth(self.frame), y: 0)
        self.addChild(self.bar3)
        
        // left bar
        self.bar4 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: self.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame)))
        self.bar4.anchorPoint = CGPoint(x: 0, y: 0)
        self.bar4.position = CGPoint(x: 0, y: 0)
        self.addChild(self.bar4)
        
        // top bar (starting left)
        self.bar5 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame)/2, height: self.TIMER_BAR_WIDTH))
        self.bar5.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar5.position = CGPoint(x: 0, y: CGRectGetHeight(self.frame))
        self.addChild(self.bar5)
        
        // start timers
        self.startTimers()
    }
    
    func startTimers()
    {
        // calculate variables
        let TOTAL_DISTANCE = 2 * CGRectGetWidth(self.frame) + 2 * CGRectGetHeight(self.frame)
        let HEIGHT_DURATION =  Double(CGFloat(self.roundTime) * (CGRectGetHeight(self.frame) / TOTAL_DISTANCE))
        let WIDTH_DURATION = Double(CGFloat(self.roundTime) * (CGRectGetWidth(self.frame) / TOTAL_DISTANCE))
        
        // animate bars
        self.bar5.runAction(SKAction.scaleXTo(0.0, duration: WIDTH_DURATION / 2), completion: {
            self.bar4.runAction(SKAction.scaleYTo(0.0, duration: HEIGHT_DURATION), completion: {
                self.bar3.runAction(SKAction.scaleXTo(0.0, duration: WIDTH_DURATION), completion: {
                    self.bar2.runAction(SKAction.scaleYTo(0.0, duration: HEIGHT_DURATION), completion: {
                        self.bar1.runAction(SKAction.scaleXTo(0.0, duration: WIDTH_DURATION / 2))
                    })
                })
            })
        })
        
        Game.sharedInstance.startTimer(self, selector: "timeRanOut")
    }
    
    private func makeEmptyBars()
    {
        // top bar (starting centered)
        self.bar1 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: TIMER_BAR_WIDTH))
        self.bar1.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar1)
        
        // right bar
        self.bar2 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame) - TIMER_BAR_WIDTH * 2))
        self.bar2.anchorPoint = CGPoint(x: 1, y: 1)
        self.bar2.position = CGPoint(x: CGRectGetWidth(self.frame), y: CGRectGetHeight(self.frame) - TIMER_BAR_WIDTH)
        self.addChild(self.bar2)
        
        // bottom bar
        self.bar3 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame), height: TIMER_BAR_WIDTH))
        self.bar3.anchorPoint = CGPoint(x: 1, y: 0)
        self.bar3.position = CGPoint(x: CGRectGetWidth(self.frame), y: 0)
        self.addChild(self.bar3)
        
        // left bar
        self.bar4 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame) - TIMER_BAR_WIDTH * 2))
        self.bar4.anchorPoint = CGPoint(x: 0, y: 0)
        self.bar4.position = CGPoint(x: 0, y: TIMER_BAR_WIDTH)
        self.addChild(self.bar4)
        
        // top bar (starting left)
        self.bar5 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: TIMER_BAR_WIDTH))
        self.bar5.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar5.position = CGPoint(x: 0, y: CGRectGetHeight(self.frame))
        self.addChild(self.bar5)
    }

    
    func gotItButtonTapped(button: CoolButton)
    {
        if let roundEndedScene = RoundEndedScene(fileNamed: "RoundEndedScene")
        {
            // tell the model
            Game.sharedInstance.answeredCorrectly()
            
            // set the name
            if Game.sharedInstance.guessingTeam.teamColor == TeamColor.Blue
            {
                roundEndedScene.teamName = "Blue"
            }
            else
            {
                roundEndedScene.teamName = "Yellow"
            }
            
            // they scored
            roundEndedScene.scored = true
            
            // stop the timer bar from moving
            self.bar1.removeAllActions()
            self.bar2.removeAllActions()
            self.bar3.removeAllActions()
            self.bar4.removeAllActions()
            self.bar5.removeAllActions()
            
            // present the winning view
            self.view?.presentScene(roundEndedScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func timeRanOut()
    {
        if let roundEndedScene = RoundEndedScene(fileNamed: "RoundEndedScene")
        {
            // set the name
            if Game.sharedInstance.guessingTeam.teamColor == TeamColor.Yellow
            {
                roundEndedScene.teamName = "Blue"
            }
            else
            {
                roundEndedScene.teamName = "Yellow"
            }
            
            // they scored
            roundEndedScene.scored = false
            
            // present the winning view
            self.view?.presentScene(roundEndedScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func connectivityStatusChanged(connected: Bool)
    {
        
    }
}