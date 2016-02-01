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
            if let data = data, let blueTeam = data["blueTeam"] as? Bool
            {
                choosingScene.blueTeam = blueTeam
            }
            
            currentScene.view?.presentScene(choosingScene, transition: SKTransition.fadeWithDuration(0.5))
        }
        break
        
    case .Playing:
        if let timerScene = TimerScene(fileNamed: "TimerScene")
        {
            if let data = data, let roundTime = data["roundTime"] as? NSTimeInterval, let blueTeam = data["blueTeam"] as? Bool
            {
                timerScene.roundTime = roundTime
                timerScene.blueTeam = blueTeam
            }
            
            currentScene.view?.presentScene(timerScene, transition: SKTransition.fadeWithDuration(0.5))
        }
        break
    case .ResetAll:
        if let connectedScene = ConnectedScene(fileNamed: "ConnectedScene")
        {
            TeamScoreView.sharedYellowInstance.resetAll()
            TeamScoreView.sharedBlueInstance.resetAll()
            
            currentScene.view?.presentScene(connectedScene, transition: SKTransition.fadeWithDuration(0.5))
        }
        break
    }
}