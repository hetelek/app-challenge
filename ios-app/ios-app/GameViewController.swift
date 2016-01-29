//
//  GameViewController.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/28/16.
//  Copyright (c) 2016 RyanDannyStevie. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController
{
    override func viewWillAppear(animated: Bool)
    {
        let scene = MenuScene(fileNamed: "MenuScene")
        let spriteView = self.view as! SKView
        
        spriteView.presentScene(scene)
    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        return .Landscape
    }
}
