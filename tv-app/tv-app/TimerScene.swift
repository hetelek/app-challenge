//
//  TimerScene.swift
//  tv-app
//
//  Created by Stevie Hetelekides on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class TimerScene : SKScene, CommunicatorProtocol
{
    private var contentCreated = false
    
    var bar1: SKSpriteNode!
    var bar2: SKSpriteNode!
    var bar3: SKSpriteNode!
    var bar4: SKSpriteNode!
    var bar5: SKSpriteNode!
    
    var roundTime: NSTimeInterval = 30
    let TIMER_BAR_WIDTH: CGFloat = 25
    let SCORE_PANE_PADDING: CGFloat = 20
    
    override func didMoveToView(view: SKView)
    {
        Communicator.sharedInstance.delegate = self
        
        // create the content if we haven't already
        if !self.contentCreated
        {
            createContent()
            self.contentCreated = true
        }
    }
    
    private func createContent()
    {
        // set scale
        self.scaleMode = .ResizeFill
        
        // screen center
        let centerX = CGRectGetMidX(self.frame)
        
        // set background color to yellow
        self.backgroundColor = SKColor.gameYellowColor()
        
        // make right half blue
        let bluePanel = SKSpriteNode(color: SKColor.gameBlueColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: CGRectGetHeight(self.frame)))
        bluePanel.anchorPoint = CGPoint(x: 0, y: 1)
        bluePanel.position = CGPoint(x: centerX, y: CGRectGetMaxY(self.frame))
        self.addChild(bluePanel)
        
        // score panel offset
        let scoreOffset = TIMER_BAR_WIDTH + SCORE_PANE_PADDING
        
        // create yellow score pane
        let yellowScore = TeamScoreView(teamColor: TeamColor.Yellow, width: centerX - (scoreOffset * 2))
        yellowScore.position = CGPoint(x: scoreOffset, y: scoreOffset)
        self.addChild(yellowScore)
        
        // create blue score pane
        let blueScore = TeamScoreView(teamColor: TeamColor.Blue, width: centerX - (scoreOffset * 2))
        blueScore.position = CGPoint(x: CGRectGetWidth(self.frame) - scoreOffset, y: scoreOffset)
        self.addChild(blueScore)
        
        // start timers
        self.startTimers()
        
        yellowScore.addPointBar()
        yellowScore.addPointBar()
        yellowScore.addPointBar()
        yellowScore.addPointBar()
        yellowScore.addPointBar()
        yellowScore.addPointBar()
        
        blueScore.addPointBar()
    }

    func startTimers()
    {
        // top bar (starting centered)
        self.bar1 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: self.TIMER_BAR_WIDTH))
        self.bar1.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar1)
        
        // right bar
        self.bar2 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: self.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame)))
        self.bar2.anchorPoint = CGPoint(x: 1, y: 1)
        self.bar2.position = CGPoint(x: CGRectGetWidth(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar2)
        
        // bottom bar
        self.bar3 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame), height: self.TIMER_BAR_WIDTH))
        self.bar3.anchorPoint = CGPoint(x: 1, y: 0)
        self.bar3.position = CGPoint(x: CGRectGetWidth(self.frame), y: 0)
        self.addChild(self.bar3)
        
        // left bar
        self.bar4 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: self.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame)))
        self.bar4.anchorPoint = CGPoint(x: 0, y: 0)
        self.bar4.position = CGPoint(x: 0, y: 0)
        self.addChild(self.bar4)
        
        // top bar (starting left)
        self.bar5 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: self.TIMER_BAR_WIDTH))
        self.bar5.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar5.position = CGPoint(x: 0, y: CGRectGetHeight(self.frame))
        self.addChild(self.bar5)
        
        // calculate variables
        let TOTAL_DISTANCE = 2 * CGRectGetWidth(self.frame) + 2 * CGRectGetHeight(self.frame)
        let HEIGHT_DURATION =  Double(CGFloat(self.roundTime) * (CGRectGetHeight(self.frame) / TOTAL_DISTANCE))
        let WIDTH_DURATION = Double(CGFloat(self.roundTime) * (CGRectGetWidth(self.frame) / TOTAL_DISTANCE))
        
        // animate bars
        self.bar5.runAction(SKAction.scaleXTo(0.0, duration: WIDTH_DURATION / 2), completion: {
            self.bar4.runAction(SKAction.scaleYTo(0.0, duration: HEIGHT_DURATION), completion: {
                self.bar3.runAction(SKAction.scaleXTo(0.0, duration: WIDTH_DURATION), completion: {
                    self.bar2.runAction(SKAction.scaleYTo(0.0, duration: HEIGHT_DURATION), completion: {
                        self.bar1.runAction(SKAction.scaleXTo(0.0, duration: WIDTH_DURATION / 2))
                    })
                })
            })
        })
    }

    func connectivityStatusChanged(connected: Bool)
    {
        // if we're disconnected, present the waiting screen
        if !connected, let waitingScene = WaitingForDeviceScene(fileNamed: "WaitingForDeviceScene")
        {
            self.view?.presentScene(waitingScene, transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func receivedData(scene: Scene, data: [String: AnyObject]?)
    {
        
    }
}