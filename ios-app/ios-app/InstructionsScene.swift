//
//  InstructionsScene.swift
//  ios-app
//
//  Created by Danny Hawk on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//
import SpriteKit

class InstructionsScene : SKScene
{
    var contentCreated = false
    let padding: CGFloat = 160
    let instructionString = "Pick Their Poison is played by two teams, Blue Team and Yellow Team, where turns alternate between the teams. A turn starts with one team picking the word and modifier that a member of the opposing team has to act out. A modifier is a rule that has to be abided by while acting out the word. All other members of a team have to guess the word attempted to be acted out by their teammate. If it is guessed correctly, the actor must hit the confirm button on their device, otherwise time expires and they don’t receive a point. One point is awarded for every successful guess, with one team being declared the winner if they accrue 6 points."
    
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
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = SKColor.gameYellowColor()
        
        // add instructions label
        let instructionsLabel = DSMultilineLabelNode(fontNamed: "Raleway-Bold")
        instructionsLabel.paragraphWidth = CGRectGetWidth(self.frame) - self.padding * 2
        instructionsLabel.text = instructionString
        instructionsLabel.position = CGPoint(x: 0, y: 0)
        instructionsLabel.fontSize = 22
        instructionsLabel.horizontalAlignmentMode = .Left
        instructionsLabel.fontColor = SKColor.gameBlueColor()
        
        self.addChild(instructionsLabel)
        
        // add tap to continue label
        let tapLabel  = SKLabelNode(fontNamed: "Raleway-Bold")
        tapLabel.text = "Tap to continue"
        tapLabel.position = CGPoint(x: 0, y: -CGRectGetHeight(self.frame) / 2 + self.padding)
        tapLabel.fontSize = 14
        tapLabel.fontColor = SKColor.gameBlueColor()
        
        self.addChild(tapLabel)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        // present next scene (select choice)
        if let confirmStartScreen = ConfirmStartScene(fileNamed: "ConfirmStartScene")
        {
            self.view?.presentScene(confirmStartScreen, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
}