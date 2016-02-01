//
//  PickTheirPoisonScene.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class PickTheirPoisonScene : SKScene
{
    var contentCreated = false
    
    override func didMoveToView(view: SKView)
    {
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
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // variables for 2 states (blue picking, yellow picking)
        var colors: [SKColor] = [ ]
        var topText: String
        
        // set variables based on who's picking
        let blueIsPicking = Game.sharedInstance.choosingTeam.teamColor == TeamColor.Blue
        if !blueIsPicking
        {
            colors.append(SKColor.gameBlueColor())
            colors.append(SKColor.gameYellowColor())
            topText = "Team Blue"
        }
        else
        {
            colors.append(SKColor.gameYellowColor())
            colors.append(SKColor.gameBlueColor())
            topText = "Team Yellow"
        }
        
        // create start button
        let teamButton = CoolButton(color:colors[1], size: CGSize(width: CGRectGetWidth(self.frame) + 5, height: CGRectGetHeight(self.frame) / 2 + 5))
        teamButton.text = topText
        teamButton.label.fontName = "Raleway-Bold"
        teamButton.flatColor = true
        teamButton.label.fontSize = 64
        teamButton.fontColor = colors[0]
        teamButton.addTarget(self, selector: "continueButtonTapped:")
        teamButton.position = CGPoint(x: 0, y: CGRectGetHeight(self.frame) / 4)
        
        self.addChild(teamButton)
        
        // create pick poison button
        let pickPoisonButton = CoolButton(color: colors[0], size: CGSize(width: CGRectGetWidth(self.frame) + 5, height: CGRectGetHeight(self.frame) / 2 + 5))
        pickPoisonButton.text = "Pick Their Poison"
        pickPoisonButton.label.fontName = "Raleway-Bold"
        pickPoisonButton.flatColor = true
        pickPoisonButton.label.fontSize = 64
        pickPoisonButton.fontColor = colors[1]
        pickPoisonButton.position = CGPoint(x: 0, y: -CGRectGetHeight(self.frame) / 4)
        pickPoisonButton.addTarget(self, selector: "continueButtonTapped:")
        
        self.addChild(pickPoisonButton)
        
        // tap to continue label
        let continueLabel = SKLabelNode(text: "Tap to Continue")
        continueLabel.fontSize = 32
        continueLabel.fontName = "Raleway-Bold"
        continueLabel.fontColor = colors[1]
        continueLabel.position = CGPoint(x: 0, y: -CGRectGetHeight(self.frame) / 4 - 65)
        
        self.addChild(continueLabel)
    }
    
    func continueButtonTapped(button: CoolButton)
    {
        // present next scene
        if let selectScene = SelectScene(fileNamed: "SelectScene")
        {
            self.view?.presentScene(selectScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
}
