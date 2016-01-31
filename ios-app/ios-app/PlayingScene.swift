//
//  PlayingScene.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class PlayingScene : SKScene
{
    var contentCreated = false
    var bar1: SKSpriteNode!
    var bar2: SKSpriteNode!
    var bar3: SKSpriteNode!
    var bar4: SKSpriteNode!
    var bar5: SKSpriteNode!
    
    
    let ROUND_TIMER: CGFloat = 30
    let TIMER_BAR_WIDTH: CGFloat = 17
    var GOT_IT_SIZE = CGSize(width: 100, height: 100)
    var TAP_TO_VIEW_SIZE = CGSize(width: 100, height: 100)
    let PADDING_FROM_CENTER: CGFloat = 0
    
    
    
    var screenRatio: CGFloat!
    
    override func didMoveToView(view: SKView)
    {
        self.screenRatio = self.frame.width / self.frame.height
        //Game.sharedInstance.startTimer(self, selector: "timeRanOut")
        
        //resetting the values for size because I couldn't get the screen dimensions out of function scope
        GOT_IT_SIZE = CGSize(width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)/2)
        TAP_TO_VIEW_SIZE = CGSize(width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)/2)

        
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
        
        // create got it button
        let gotItButton = CoolButton(color: SKColor.gameYellowColor(), size: self.GOT_IT_SIZE)
        gotItButton.text = "Guessed Correctly"
        gotItButton.fontColor = SKColor.gameBlueColor()
        gotItButton.position = CGPoint(x: centerX, y: centerY - (self.GOT_IT_SIZE.height + self.PADDING_FROM_CENTER)/2)
        gotItButton.addTarget(self, selector: "gotItButtonTapped:")
        
        self.addChild(gotItButton)
        
        // create instructions pane
        let instructionsPane = TapToViewPane(color: SKColor.gameBlueColor(), size: self.TAP_TO_VIEW_SIZE)
        instructionsPane.unhiddenText = "Tap and hold to view"
        instructionsPane.fontColor = SKColor.gameYellowColor()
        instructionsPane.label.fontSize = 32
        instructionsPane.label.fontName = "Raleway-Bold"
        instructionsPane.hiddenText = Game.sharedInstance.selectedModifier.fullText
        instructionsPane.position = CGPoint(x: centerX, y: centerY + (self.GOT_IT_SIZE.height + self.PADDING_FROM_CENTER)/2)
        
        self.addChild(instructionsPane)
        
        // top bar (starting centered)
        self.bar1 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame)/2, height: self.TIMER_BAR_WIDTH))
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
        
        //var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("startTimers"), userInfo: nil, repeats: true)
        startTimers()
    }
    
    func startTimers()
    {
        let TOTAL_DISTANCE = 2 * CGRectGetWidth(self.frame) + 2 * CGRectGetHeight(self.frame)
        let HEIGHT_DURATION =  (ROUND_TIMER * ((2 * CGRectGetHeight(self.frame)) / TOTAL_DISTANCE)) / 2.0
        let WIDTH_DURATION = (ROUND_TIMER * ((2 * CGRectGetWidth(self.frame)) / TOTAL_DISTANCE)) / 2.0
        self.bar5.runAction(SKAction.scaleXTo(0.0, duration: Double(WIDTH_DURATION) / 2.0),
            completion: { self.bar4.runAction(SKAction.scaleYTo(0.0, duration: Double(HEIGHT_DURATION)),
                completion: {self.bar3.runAction(SKAction.scaleXTo(0.0, duration: Double(WIDTH_DURATION)),
                    completion: {self.bar2.runAction(SKAction.scaleYTo(0.0, duration: Double(HEIGHT_DURATION)),
                        completion: {self.bar1.runAction(SKAction.scaleXTo(0.0, duration: Double(WIDTH_DURATION) / 2.0),
                            completion: {self.timeRanOut()})})})})})
    }
    
    func gotItButtonTapped(button: CoolButton)
    {
        print("got it")
    }
    
    func timeRanOut()
    {
        print("time ran out!")
    }
}