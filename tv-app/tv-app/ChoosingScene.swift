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
        let leftLabel = SKLabelNode(text: "Pick Your Poison:")
        leftLabel.position = CGPoint(x: centerX - 10, y: centerY)
        leftLabel.fontName = "Raleway-Bold"
        leftLabel.fontSize = 32
        leftLabel.horizontalAlignmentMode = .Right
        leftLabel.fontColor = SKColor.gameBlueColor()
        self.addChild(leftLabel)
        
        // create right label
        let teamName = self.blueTeam! ? "Blue" : "Yellow"
        
        let rightLabel = SKLabelNode(text: teamName)
        rightLabel.position = CGPoint(x: centerX + 10, y: centerY)
        rightLabel.fontName = "Raleway-Bold"
        rightLabel.fontSize = 32
        rightLabel.horizontalAlignmentMode = .Left
        rightLabel.fontColor = SKColor.gameYellowColor()
        self.addChild(rightLabel)
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