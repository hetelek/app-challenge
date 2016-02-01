//
//  ConnectedScene.swift
//  tv-app
//
//  Created by Stevie Hetelekides on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class ConnectedScene : SKScene, CommunicatorProtocol
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
        
        // add image and title here
        let titleLabel = SKLabelNode(text: "Pick Their Poison")
        titleLabel.position = CGPoint(x: 0, y: 0)
        titleLabel.fontName = "Raleway-Bold"
        titleLabel.fontSize = 100
        titleLabel.fontColor = SKColor.gameBlueColor()
        self.addChild(titleLabel)
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