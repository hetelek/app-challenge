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
    var showingWinner = false
    var label: SKLabelNode!
    
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
            self.label = SKLabelNode(text: text)
            self.label.position = CGPoint(x: 0, y: 0)
            self.label.fontColor = blueJustWent ? SKColor.gameBlueColor() : SKColor.gameYellowColor()
            self.label.fontSize = 96
            self.label.fontName = "Raleway-Bold"
            
            self.addChild(self.label)
            
            // tap to continue label
            let continueLabel = SKLabelNode(text: "Tap to Continue")
            continueLabel.fontSize = 32
            continueLabel.fontName = "Raleway-Bold"
            continueLabel.fontColor = blueJustWent ? SKColor.gameBlueColor() : SKColor.gameYellowColor()
            continueLabel.position = CGPoint(x: 0, y: -80)
            
            self.addChild(continueLabel)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if !self.showingWinner
        {
            if Game.sharedInstance.teams[0].score >= 6
            {
                self.showingWinner = true
                self.label.runAction(SKAction.fadeOutWithDuration(0.15), completion: { () -> Void in
                    self.label.text = "\(Game.sharedInstance.teams[0].teamColor) wins!"
                    self.label.runAction(SKAction.fadeInWithDuration(0.15))
                })
            }
            else if Game.sharedInstance.teams[1].score >= 6
            {
                self.showingWinner = true
                self.label.runAction(SKAction.fadeOutWithDuration(0.15), completion: { () -> Void in
                    self.label.text = "\(Game.sharedInstance.teams[1].teamColor) wins!"
                    self.label.runAction(SKAction.fadeInWithDuration(0.15))
                })
            }
            else if let pickTheirPoisonScene = PickTheirPoisonScene(fileNamed: "PickTheirPoisonScene")
            {
                self.view?.presentScene(pickTheirPoisonScene, transition: SKTransition.fadeWithDuration(0.5))
            }
        }
        else
        {
        }
    }
}