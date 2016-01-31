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
        
        // calculate padding
        let scoreOffset = TimerScene.TIMER_BAR_WIDTH + TimerScene.SCORE_PANE_PADDING
        
        // calculate width / positions
        TeamScoreView.sharedYellowInstance.size.width = centerX - (scoreOffset * 2)
        TeamScoreView.sharedBlueInstance.size.width = centerX - (scoreOffset * 2)
        
        TeamScoreView.sharedYellowInstance.position = CGPoint(x: scoreOffset, y: scoreOffset)
        TeamScoreView.sharedBlueInstance.position = CGPoint(x: CGRectGetWidth(self.frame) - scoreOffset, y: scoreOffset)
        
        self.addChild(TeamScoreView.sharedYellowInstance)
        self.addChild(TeamScoreView.sharedBlueInstance)
        
        // create waiting label
        let waitingLabel = SKLabelNode(text: "Pick your poison!")
        waitingLabel.position = CGPoint(x: centerX, y: centerY)
        self.addChild(waitingLabel)
    }
    
    func receivedData(data: [String: AnyObject])
    {
        print(data)
    }
    
    func receivedData(scene: Scene, data: [String: AnyObject]?)
    {
        print("\(scene): \(data)")
        if scene == Scene.Playing, let timerScene = TimerScene(fileNamed: "TimerScene")
        {
            if let data = data, let roundTime = data["roundTime"] as? NSTimeInterval
            {
                timerScene.roundTime = roundTime
            }
            
            self.view?.presentScene(timerScene, transition: SKTransition.fadeWithDuration(0.5))
        }
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