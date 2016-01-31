//
//  ConfirmStartScene.swift
//  ios-app
//
//  Created by Danny Hawk on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class ConfirmStartScene : SKScene
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
        
        // create start button
        let startGameButton = CoolButton(color: SKColor.gameYellowColor(), size: CGSize(width: CGRectGetWidth(self.frame) + 5, height: CGRectGetHeight(self.frame) / 2 + 5))
        startGameButton.text = "Start Game"
        startGameButton.label.fontName = "Raleway-Bold"
        startGameButton.flatColor = true
        startGameButton.label.fontSize = 32
        startGameButton.fontColor = SKColor.gameBlueColor()
        startGameButton.addTarget(self, selector: "startGameButtonTapped:")
        startGameButton.position = CGPoint(x: 0, y: CGRectGetHeight(self.frame) / 4)
        
        self.addChild(startGameButton)
        
        // create instructions button
        let instructionsButton = CoolButton(color: SKColor.gameBlueColor(), size: CGSize(width: CGRectGetWidth(self.frame) + 5, height: CGRectGetHeight(self.frame) / 2 + 5))
        instructionsButton.text = "Instructions"
        instructionsButton.label.fontName = "Raleway-Bold"
        instructionsButton.flatColor = true
        instructionsButton.label.fontSize = 32
        instructionsButton.fontColor = SKColor.gameYellowColor()
        instructionsButton.position = CGPoint(x: 0, y: -CGRectGetHeight(self.frame) / 4)
        instructionsButton.addTarget(self, selector: "instructionsButtonTapped:")
        
        self.addChild(instructionsButton)
    }
    
    func startGameButtonTapped(button: CoolButton)
    {
        // present next scene
        if let pickTheirPoisonScene = PickTheirPoisonScene(fileNamed: "PickTheirPoisonScene")
        {
            self.view?.presentScene(pickTheirPoisonScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func instructionsButtonTapped(button: CoolButton)
    {
        // present next scene (instructions)
        if let instructionsScreen = InstructionsScene(fileNamed: "InstructionsScene")
        {
            self.view?.presentScene(instructionsScreen, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
}
