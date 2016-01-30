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
    
    let TIMER_BAR_WIDTH: CGFloat = 10
    let GOT_IT_SIZE = CGSize(width: 300, height: 100)
    let TAP_TO_VIEW_SIZE = CGSize(width: 300, height: 100)
    let PADDING_FROM_CENTER: CGFloat = 10
    
    var screenRatio: CGFloat!
    
    override func didMoveToView(view: SKView)
    {
        self.screenRatio = self.frame.width / self.frame.height
        Game.sharedInstance.startTimer(self, selector: "timeRanOut")
        
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
        let gotItButton = CoolButton(color: SKColor.blackColor(), size: self.GOT_IT_SIZE)
        gotItButton.text = "Got it!"
        gotItButton.position = CGPoint(x: centerX, y: centerY + (self.GOT_IT_SIZE.height + self.PADDING_FROM_CENTER))
        gotItButton.addTarget(self, selector: "gotItButtonTapped:")
        
        self.addChild(gotItButton)
        
        // create instructions pane
        let instructionsPane = TapToViewPane(color: SKColor.blackColor(), size: self.TAP_TO_VIEW_SIZE)
        instructionsPane.unhiddenText = "Tap and hold to view"
        instructionsPane.hiddenText = "Tree with your eyes closed"
        instructionsPane.position = CGPoint(x: centerX, y: centerY - (self.GOT_IT_SIZE.height + self.PADDING_FROM_CENTER))
        
        self.addChild(instructionsPane)
        
        /*
        // top bar (starting centered)
        self.bar1 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 0, height: self.TIMER_BAR_WIDTH))
        self.bar1.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar1)
        
        // right bar
        self.bar2 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: self.TIMER_BAR_WIDTH, height: 0))
        self.bar2.anchorPoint = CGPoint(x: 1, y: 1)
        self.bar2.position = CGPoint(x: CGRectGetWidth(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar2)
        
        // bottom bar
        self.bar3 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 0, height: self.TIMER_BAR_WIDTH))
        self.bar3.anchorPoint = CGPoint(x: 1, y: 0)
        self.bar3.position = CGPoint(x: CGRectGetWidth(self.frame), y: 0)
        self.addChild(self.bar3)
        
        // left bar
        self.bar4 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: self.TIMER_BAR_WIDTH, height: 0))
        self.bar4.anchorPoint = CGPoint(x: 0, y: 0)
        self.bar4.position = CGPoint(x: 0, y: 0)
        self.addChild(self.bar4)
        
        // top bar (starting left)
        self.bar5 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 0, height: self.TIMER_BAR_WIDTH))
        self.bar5.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar5.position = CGPoint(x: 0, y: CGRectGetHeight(self.frame))
        self.addChild(self.bar5)
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "startTimer", userInfo: nil, repeats: false)
        */
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
