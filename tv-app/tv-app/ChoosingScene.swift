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
        
        let waitingLabel = SKLabelNode(text: "Pick your poison!")
        waitingLabel.position = CGPoint(x: centerX, y: centerY)
        self.addChild(waitingLabel)
    }
    
    func receivedData(data: [String: AnyObject])
    {
        print(data)
    }
    
    func connectivityStatusChanged(connected: Bool)
    {
        print("connected: \(connected)")
    }
}