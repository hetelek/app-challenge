
//  PassDeviceScene.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.


import SpriteKit

class PassDeviceScene : SKScene, CommunicatorDelegate
{
    var contentCreated = false
    
    // button spacing
    private let HORIZONTAL_SPACING: CGFloat = 0
    private let VERTICAL_SPACING: CGFloat = 0
    
    override func didMoveToView(view: SKView)
    {
        Communicator.sharedInstance.delegate = self
        
        // get the current team
        let blueIsChoosing = Game.sharedInstance.choosingTeam.teamColor == TeamColor.Blue
        
        // send our state
        Communicator.sharedInstance.sendData(.PassDevice, data: [ "blueTeam": blueIsChoosing ])
        
        // create the content if we haven't already
        if !self.contentCreated
        {
            self.createContent()
            self.contentCreated = true
        }
    }
    
    private func createContent()
    {
        // set background color/scale
        self.scaleMode = .ResizeFill
        self.backgroundColor = SKColor.gameYellowColor()
        
        // screen center
        let centerX = CGRectGetMidX(self.frame)
        let centerY = CGRectGetMidY(self.frame)
        
        // create label
        let continueLabel = SKLabelNode(text: "Pass the device to continue...")
        continueLabel.fontName = "Raleway-Bold"
        continueLabel.position = CGPoint(x: centerX, y: centerY * 1.5)
        continueLabel.fontColor = SKColor.gameBlueColor()
        continueLabel.fontSize = 24
        
        self.addChild(continueLabel)
        
        // calcualte width and height of the button
        let width = self.frame.size.width - self.HORIZONTAL_SPACING * 2
        let height = self.frame.size.height / 2 - self.VERTICAL_SPACING * 1.5
        
        // calculate y coordinate (relative from edge of screen)
        let y = self.HORIZONTAL_SPACING + height / 2
        
        // create bottom button
        let continueButton = CoolButton(color: SKColor.gameBlueColor(), size: CGSize(width: width, height: height))
        continueButton.position = CGPoint(x: centerX, y: y)
        continueButton.text = "Tap to Continue"
        continueButton.fontColor = SKColor.gameYellowColor()
        continueButton.addTarget(self, selector: "continueButtonTapped:")
        
        self.addChild(continueButton)
    }
    
    func continueButtonTapped(button: CoolButton)
    {
        // present start scene
        if let startScene = StartScene(fileNamed: "StartScene")
        {
            self.view?.presentScene(startScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func connectivityStatusChanged(connected: Bool)
    {
        
    }
}