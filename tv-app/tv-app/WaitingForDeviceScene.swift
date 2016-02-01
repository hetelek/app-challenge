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
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // set background color
        self.backgroundColor = SKColor.gameYellowColor()
        
        // create waiting label
        let waitingLabel = SKLabelNode(text: "Waiting for device")
        waitingLabel.position = CGPoint(x: 0, y: 0)
        waitingLabel.fontName = "Raleway-Bold"
        waitingLabel.fontSize = 64
        waitingLabel.fontColor = SKColor.gameBlueColor()
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