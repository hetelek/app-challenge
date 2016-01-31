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
        
        // screen center
        let centerX = CGRectGetMidX(self.frame)
        let centerY = CGRectGetMidY(self.frame)
    }
}