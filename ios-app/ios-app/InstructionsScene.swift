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
    let padding: CGFloat = 10
    let instructionString = "Separate into two teams, minimum of two people to a team. One team takes a turn selecting the thing to be acted out, and the accompanying poison to make it difficult. One member of the opposing team receives the iphone/ipad and presses start. They then quickly read the instructions and act out the thing following their specific rules. If guessed correctly by their teammates, the actor presses the “guessed correctly” button and that team is awarded one point. They then pick for the opposing team."
    
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
        
        let x = DSMultilineLabelNode(fontNamed: "Raleway-Regular")
        x.paragraphWidth = CGRectGetWidth(self.frame) - self.padding * 2
        x.text = instructionString
        x.position = CGPoint(x: padding, y: padding)
        self.addChild(x)
    }
}