//
//  SceneStateHandler.swift
//  tv-app
//
//  Created by Stevie Hetelekides on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

func updateStateFromData(scene: Scene, data: [String: AnyObject]?, currentScene: SKScene)
{
    switch scene
    {
    case .Menu:
        if let connectedScene = ConnectedScene(fileNamed: "ConnectedScene")
        {
            currentScene.view?.presentScene(connectedScene, transition: SKTransition.fadeWithDuration(0.5))
        }
        break
        
    case .SelectChoice, .SelectModifier, .Start, .PassDevice:
        if currentScene.isKindOfClass(ChoosingScene)
        {
            break
        }
        
        if let choosingScene = ChoosingScene(fileNamed: "ChoosingScene")
        {
            if let data = data, let team = data["team"] as? String
            {
                choosingScene.team = team
            }
            
            currentScene.view?.presentScene(choosingScene, transition: SKTransition.fadeWithDuration(0.5))
        }
        break
        
    case .Playing:
        if let timerScene = TimerScene(fileNamed: "TimerScene")
        {
            if let data = data, let roundTime = data["roundTime"] as? NSTimeInterval
            {
                timerScene.roundTime = roundTime
            }
            
            currentScene.view?.presentScene(timerScene, transition: SKTransition.fadeWithDuration(0.5))
        }
        break
    }
}