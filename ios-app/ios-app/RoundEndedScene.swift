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
        // set scale
        self.scaleMode = .ResizeFill
        
        // set anchor
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        if let teamName = teamName, let scored = self.scored
        {
            // set background color
            let blueJustWent = teamName == "Blue"
            self.backgroundColor = blueJustWent ? SKColor.gameYellowColor() : SKColor.gameBlueColor()
            
            // set text
            var text: String
            if scored
            {
                text = "Good work \(teamName)!"
            }
            else
            {
                text = "Nice try \(teamName)..."
            }
            
            // add text label
            let label = SKLabelNode(text: text)
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 24
            label.fontColor = blueJustWent ? SKColor.gameBlueColor() : SKColor.gameYellowColor()
            label.fontSize = 32
            label.fontName = "Raleway-Bold"
            
            self.addChild(label)
            
            // tap to continue label
            let continueLabel = SKLabelNode(text: "Tap to continue")
            continueLabel.fontSize = 16
            continueLabel.fontName = "Raleway-Regular"
            continueLabel.fontColor = blueJustWent ? SKColor.gameBlueColor() : SKColor.gameYellowColor()
            continueLabel.position = CGPoint(x: 0, y: -30)
            
            self.addChild(continueLabel)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if let pickTheirPoisonScene = PickTheirPoisonScene(fileNamed: "PickTheirPoisonScene")
        {
            self.view?.presentScene(pickTheirPoisonScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
}