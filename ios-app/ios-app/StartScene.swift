//
//  StartScene.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class StartScene : SKScene, CommunicatorDelegate
{
    var contentCreated = false
    
    override func didMoveToView(view: SKView)
    {
        Communicator.sharedInstance.delegate = self
        
        // get the current team
        let blueIsChoosing = Game.sharedInstance.choosingTeam.teamColor == TeamColor.Blue
        
        // send our state
        Communicator.sharedInstance.sendData(.Start, data: [ "blueTeam": blueIsChoosing ])
        
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
        
        // create start button
        let startButton = CoolButton(color: SKColor.gameBlueColor(), size: CGSize(width: self.size.width, height: self.size.height))
        startButton.text = "Tap to Start Round"
        startButton.flatColor = true
        startButton.label.fontSize = 64
        startButton.fontColor = SKColor.gameYellowColor()
        startButton.position = CGPoint(x: centerX, y: centerY)
        startButton.addTarget(self, selector: "startButtonTapped:")
        
        self.addChild(startButton)
    }
    
    func startButtonTapped(button: CoolButton)
    {
        if let playingScene = PlayingScene(fileNamed: "PlayingScene")
        {
            self.view?.presentScene(playingScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func connectivityStatusChanged(connected: Bool)
    {
        
    }
}