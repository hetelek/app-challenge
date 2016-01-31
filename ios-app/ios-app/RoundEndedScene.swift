//
//  WinnerScene.swift
//  ios-app
//
//  Created by Danny Hawk on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class RoundEndedScene : SKScene
{
    var contentCreated = false
    var scored: Bool?
    var teamName: String?
    
    override func didMoveToView(view: SKView)
    {
        if let scored = self.scored
        {
            Communicator.sharedInstance.sendData(Scene.Playing, data: [ "scored": scored ])
        }
        
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
        
        // add label
        if let teamName = teamName, let scored = self.scored
        {
            var text: String
            if scored
            {
                text = "Good work \(teamName)!"
            }
            else
            {
                text = "Nice try \(teamName)..."
            }
            
            let label = SKLabelNode(text: text)
            label.position = CGPoint(x: centerX, y: centerY)
            label.fontSize = 24
            self.addChild(label)
        }
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "viewExpired:", userInfo: nil, repeats: false)
    }
    
    func viewExpired(timer: NSTimer)
    {
        if let selectScene = SelectScene(fileNamed: "SelectScene")
        {
            self.view?.presentScene(selectScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
}