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
        
        // set background color
        self.backgroundColor = SKColor.gameYellowColor()
        
        // create waiting label
        let waitingLabel = SKLabelNode(text: "Waiting for device")
        waitingLabel.position = CGPoint(x: centerX, y: centerY)
        self.addChild(waitingLabel)
    }
    
    func receivedData(scene: Scene, data: [String: AnyObject]?)
    {
       updateStateFromData(scene, data: data, currentScene: self)
    }
    
    func connectivityStatusChanged(connected: Bool)
    {
        if connected
        {
            // present start scene
            if let connectedScene = ConnectedScene(fileNamed: "ConnectedScene")
            {
                self.view?.presentScene(connectedScene, transition: SKTransition.fadeWithDuration(0.5))
            }
        }
    }
}