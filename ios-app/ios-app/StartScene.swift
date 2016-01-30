//
//  StartScene.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class StartScene : SKScene
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
        
        // screen center
        let centerX = CGRectGetMidX(self.frame)
        let centerY = CGRectGetMidY(self.frame)
        
        // create start button
        let startButton = CoolButton(color: SKColor.blackColor(), size: CGSize(width: 400, height: 200))
        startButton.text = "Start Round"
        startButton.label.fontSize = 24
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
}