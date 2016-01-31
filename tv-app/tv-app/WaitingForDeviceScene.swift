//
//  WaitingForDeviceScene.swift
//  tv-app
//
//  Created by Stevie Hetelekides on 1/30/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class WaitingForDeviceScene : SKScene, CommunicatorProtocol
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
        let centerX = CGRectGetMidX(UIScreen.mainScreen().bounds)
        let centerY = CGRectGetMidY(UIScreen.mainScreen().bounds)
        
        let waitingLabel = SKLabelNode(text: "Please open the app on your device...")
        waitingLabel.position = CGPoint(x: centerX, y: centerY)
        self.addChild(waitingLabel)
        
        //NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "doStuff:", userInfo: nil, repeats: false)
    }
    
    func receivedData(scene: Scene, data: [String: AnyObject]?)
    {
        print("\(scene): \(data)")
    }
    
    func doStuff(timer: NSTimer)
    {
        if let timerScene = TimerScene(fileNamed: "TimerScene")
        {
            timerScene.roundTime = 30
            self.view?.presentScene(timerScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func connectivityStatusChanged(connected: Bool)
    {
        if connected
        {
            // present start scene
            if let choosingScene = ChoosingScene(fileNamed: "ChoosingScene")
            {
                self.view?.presentScene(choosingScene, transition: SKTransition.fadeWithDuration(0.5))
            }
        }
    }
}