//
//  GameScene.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/28/16.
//  Copyright (c) 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class MenuScene : SKScene, CommunicatorDelegate
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
        // set background color/scale
        self.scaleMode = .ResizeFill
        self.backgroundColor = SKColor.gameYellowColor()
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //create top button so a tap anywhere proceeds
        let buttonTop = CoolButton(color: SKColor.gameYellowColor(), size: CGSize(width: CGRectGetWidth(self.frame) + 5, height: CGRectGetHeight(self.frame) / 2 + 5))
        buttonTop.text = ""
        buttonTop.flatColor = true
        buttonTop.fontColor = SKColor.gameBlueColor()
        buttonTop.addTarget(self, selector: "startButtonTapped:")
        buttonTop.position = CGPoint(x: 0, y: CGRectGetHeight(self.frame) / 4)
        
        self.addChild(buttonTop)
        
        // create title label
        let titleLabel = SKLabelNode(text: "Pick Their Poison")
        titleLabel.position = CGPoint(x: 0, y: self.size.height / 4)
        titleLabel.fontName = "Raleway-Bold"
        titleLabel.fontSize = 74
        titleLabel.fontColor = SKColor.gameBlueColor()
        
        self.addChild(titleLabel)
        
        // create burst emitter
        let burstEmitter = self.createBurstEmitter()
        self.addChild(burstEmitter)
        
        // create start button
        let button = CoolButton(color: SKColor.gameBlueColor(), size: CGSize(width: CGRectGetWidth(self.frame) + 5, height: CGRectGetHeight(self.frame) / 2 + 5))
        button.text = "Tap to Continue"
        button.flatColor = true
        button.fontColor = SKColor.gameYellowColor()
        button.addTarget(self, selector: "startButtonTapped:")
        button.position = CGPoint(x: 0, y: -CGRectGetHeight(self.frame) / 4)
        
        self.addChild(button)
    }
    
    private func createBurstEmitter() -> SKEmitterNode
    {
        // get sparkle texture from image
        let sparkles = SKTexture(imageNamed: "particle_hard_blue")
        
        // setup emitter
        let burstEmitter = SKEmitterNode()
        burstEmitter.particleTexture = sparkles
        burstEmitter.position = CGPoint(x: 0, y: -sparkles.size().height)
        burstEmitter.particlePositionRange = CGVector(dx: self.size.width, dy: 0)
        
        //scale up based on the pt size of iphone 6
        let BASE_PARTICLE_SCALE = CGFloat(0.75 / (667.0 * 375.0))
        let INITIAL_SCALE = sqrt(BASE_PARTICLE_SCALE * (self.frame.size.height * self.frame.size.width))
        burstEmitter.particleScaleSequence = SKKeyframeSequence(keyframeValues: [INITIAL_SCALE , 0.7 * INITIAL_SCALE, 0.0 ], times: [ 0.0, 0.7, 1.0 ])
        
        burstEmitter.particleBirthRate = 10
        burstEmitter.particleLifetimeRange = 4.8
        burstEmitter.particleLifetime = 4
        
        // set acceleration (only vertical acceleration)
        burstEmitter.xAcceleration = 0
        burstEmitter.yAcceleration = 30
        
        return burstEmitter
    }
    
    func startButtonTapped(button: CoolButton)
    {
        // present next scene (select choice)
        if let confirmStartScreen = ConfirmStartScene(fileNamed: "ConfirmStartScene")
        {
            self.view?.presentScene(confirmStartScreen, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func connectivityStatusChanged(connected: Bool)
    {
        // once we're connect, notify what screen we're on
        if connected
        {
            Communicator.sharedInstance.sendData(.Menu, data: nil)
        }
    }
}
