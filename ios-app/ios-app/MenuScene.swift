//
//  GameScene.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/28/16.
//  Copyright (c) 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class MenuScene : SKScene
{
    private var contentCreated = false
    
    override func didMoveToView(view: SKView)
    {
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
        
        // screen center
        let centerX = CGRectGetMidX(self.frame)
        let centerY = CGRectGetMidY(self.frame)
        
        // create start button
        let button = CoolButton(color: UIColor(red: 250 / 255.0, green: 229 / 255.0, blue: 150 / 255.0, alpha: 1), size: CGSize(width: 400, height: 200))
        button.text = "Start"
        button.addTarget(self, selector: "startButtonTapped:")
        button.position = CGPoint(x: centerX, y: centerY)
        
        // add button to scene
        self.addChild(button)
    }
    
    func startButtonTapped(button: CoolButton)
    {
        // present next scene (select choice)
        if let selectScreen = SelectScene(fileNamed: "SelectScene")
        {
            self.view?.presentScene(selectScreen, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
}
