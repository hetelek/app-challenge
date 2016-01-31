//
//  GameViewController.swift
//  tv-app
//
//  Created by Stevie Hetelekides on 1/28/16.
//  Copyright (c) 2016 RyanDannyStevie. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let scene = WaitingForDeviceScene(fileNamed: "WaitingForDeviceScene")
        let spriteView = self.view as! SKView
        
        spriteView.presentScene(scene)
    }
}
