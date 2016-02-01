//
//  ChoosingScene.swift
//  tv-app
//
//  Created by Stevie Hetelekides on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class ChoosingScene : SKScene, CommunicatorProtocol
{
    private var contentCreated = false
    private var currentChooser: String?
    
    var bar1: SKSpriteNode!
    var bar2: SKSpriteNode!
    var bar3: SKSpriteNode!
    var bar4: SKSpriteNode!
    var bar5: SKSpriteNode!
    
    var blueTeam: Bool?
    
    override func didMoveToView(view: SKView)
    {
        Communicator.sharedInstance.delegate = self
        
        // create the content if we haven't already
        if !self.contentCreated
        {
            createContent()
            self.contentCreated = true
        }
    }
    
    private func createContent()
    {
        // set scale
        self.scaleMode = .ResizeFill
        
        // screen center
        let centerX = CGRectGetMidX(self.frame)
        let centerY = CGRectGetMidY(self.frame)
        
        // set background color to yellow
        self.backgroundColor = SKColor.gameYellowColor()
        
        // make right half blue
        let bluePanel = SKSpriteNode(color: SKColor.gameBlueColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: CGRectGetHeight(self.frame)))
        bluePanel.anchorPoint = CGPoint(x: 0, y: 1)
        bluePanel.position = CGPoint(x: centerX, y: CGRectGetMaxY(self.frame))
        self.addChild(bluePanel)
        
        // calculate padding
        let scoreOffset = TimerScene.TIMER_BAR_WIDTH + TimerScene.SCORE_PANE_PADDING
        
        // calculate width / positions
        TeamScoreView.sharedYellowInstance.removeFromParent()
        TeamScoreView.sharedBlueInstance.removeFromParent()
        
        TeamScoreView.sharedYellowInstance.size.width = centerX - (scoreOffset * 2)
        TeamScoreView.sharedBlueInstance.size.width = centerX - (scoreOffset * 2)
        
        TeamScoreView.sharedYellowInstance.position = CGPoint(x: scoreOffset, y: scoreOffset)
        TeamScoreView.sharedBlueInstance.position = CGPoint(x: CGRectGetWidth(self.frame) - scoreOffset, y: scoreOffset)
        
        self.addChild(TeamScoreView.sharedYellowInstance)
        self.addChild(TeamScoreView.sharedBlueInstance)
        
        // create left label
        let leftLabel = SKLabelNode(text: "Pick Their Poison:")
        leftLabel.position = CGPoint(x: centerX - 10, y: centerY + 30)
        leftLabel.fontName = "Raleway-Light"
        leftLabel.fontSize = 48
        leftLabel.horizontalAlignmentMode = .Right
        leftLabel.fontColor = SKColor.gameBlueColor()
        self.addChild(leftLabel)
        
        // create right label
        let teamName = self.blueTeam! ? "Blue" : "Yellow"
        
        let rightLabel = SKLabelNode(text: teamName)
        rightLabel.position = CGPoint(x: centerX + 10, y: centerY + 30)
        rightLabel.fontName = "Raleway-Bold"
        rightLabel.fontSize = 64
        rightLabel.horizontalAlignmentMode = .Left
        rightLabel.fontColor = SKColor.gameYellowColor()
        self.addChild(rightLabel)
        
        // add fake timer bars
        self.addFakeTimerBars()
    }
    
    func addFakeTimerBars()
    {
        // top bar (starting centered)
        self.bar1 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: TimerScene.TIMER_BAR_WIDTH))
        self.bar1.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar1)
        
        // right bar
        self.bar2 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: TimerScene.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame)))
        self.bar2.anchorPoint = CGPoint(x: 1, y: 1)
        self.bar2.position = CGPoint(x: CGRectGetWidth(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar2)
        
        // bottom bar
        self.bar3 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame), height: TimerScene.TIMER_BAR_WIDTH))
        self.bar3.anchorPoint = CGPoint(x: 1, y: 0)
        self.bar3.position = CGPoint(x: CGRectGetWidth(self.frame), y: 0)
        self.addChild(self.bar3)
        
        // left bar
        self.bar4 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: TimerScene.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame)))
        self.bar4.anchorPoint = CGPoint(x: 0, y: 0)
        self.bar4.position = CGPoint(x: 0, y: 0)
        self.addChild(self.bar4)
        
        // top bar (starting left)
        self.bar5 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: TimerScene.TIMER_BAR_WIDTH))
        self.bar5.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar5.position = CGPoint(x: 0, y: CGRectGetHeight(self.frame))
        self.addChild(self.bar5)
    }
    
    func receivedData(scene: Scene, data: [String: AnyObject]?)
    {
        updateStateFromData(scene, data: data, currentScene: self)
    }
    
    func connectivityStatusChanged(connected: Bool)
    {
        // if we're disconnected, present the waiting screen
        if !connected, let waitingScene = WaitingForDeviceScene(fileNamed: "WaitingForDeviceScene")
        {
            self.view?.presentScene(waitingScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
}