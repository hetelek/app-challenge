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
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // create start button
        let button = CoolButton(color: UIColor.blackColor(), size: CGSize(width: 100, height: 50))
        button.text = "Start"
        button.addTarget(self, selector: "startButtonTapped:")
        button.position = CGPoint(x: 0, y: 0)
        
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
