//
//  TimerScene.swift
//  tv-app
//
//  Created by Stevie Hetelekides on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class TimerScene : SKScene, CommunicatorProtocol
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
    }
    
    func receivedData(data: [String: AnyObject])
    {
        print(data)
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
    
    func receivedData(scene: Scene, data: [String: AnyObject]?)
    {
        
    }
}