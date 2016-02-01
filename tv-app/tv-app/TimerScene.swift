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
    
    var rightLabel: SKLabelNode!
    var leftLabel: SKLabelNode!
    var timer: NSTimer?
    
    var blueTeam: Bool = false
    var roundTime: NSTimeInterval = 30
    var timeRemaining: Int = 30
    static let TIMER_BAR_WIDTH: CGFloat = 55
    static let SCORE_PANE_PADDING: CGFloat = 20
    
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
        let centerY = CGRectGetMidY(self.frame)
        
        // set background color to yellow
        self.backgroundColor = SKColor.gameYellowColor()
        
        // make right half blue
        let bluePanel = SKSpriteNode(color: SKColor.gameBlueColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: CGRectGetHeight(self.frame)))
        bluePanel.anchorPoint = CGPoint(x: 0, y: 1)
        bluePanel.position = CGPoint(x: centerX, y: CGRectGetMaxY(self.frame))
        self.addChild(bluePanel)
        
        // calculate padding
        let scoreOffset = TimerScene.TIMER_BAR_WIDTH + TimerScene.SCORE_PANE_PADDING
        
        // calculate width / positions
        TeamScoreView.sharedYellowInstance.removeFromParent()
        TeamScoreView.sharedBlueInstance.removeFromParent()
        
        TeamScoreView.sharedYellowInstance.size.width = centerX - (scoreOffset * 2)
        TeamScoreView.sharedBlueInstance.size.width = centerX - (scoreOffset * 2)
        
        TeamScoreView.sharedYellowInstance.position = CGPoint(x: scoreOffset, y: scoreOffset)
        TeamScoreView.sharedBlueInstance.position = CGPoint(x: CGRectGetWidth(self.frame) - scoreOffset, y: scoreOffset)
        
        self.addChild(TeamScoreView.sharedYellowInstance)
        self.addChild(TeamScoreView.sharedBlueInstance)
        
        self.timeRemaining = Int(roundTime)
        
        // create left label
        self.leftLabel = SKLabelNode(text: "3")
        self.leftLabel.position = CGPoint(x: centerX - 5, y: centerY)
        self.leftLabel.fontName = "Akashi"
        self.leftLabel.fontSize = 200
        self.leftLabel.horizontalAlignmentMode = .Right
        self.leftLabel.fontColor = SKColor.gameBlueColor()
        self.addChild(self.leftLabel)
        
        // create right label
        self.rightLabel = SKLabelNode(text: "0")
        self.rightLabel.position = CGPoint(x: centerX + 5, y: centerY)
        self.rightLabel.fontName = "Akashi"
        self.rightLabel.fontSize = 200
        self.rightLabel.horizontalAlignmentMode = .Left
        self.rightLabel.fontColor = SKColor.gameYellowColor()
        self.addChild(self.rightLabel)
        
        // start timers
        self.startTimers()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "tick:", userInfo: nil, repeats: true)
    }
    
    func updateLabels()
    {
        let left = String(self.timeRemaining / 10)
        let right = String(self.timeRemaining % 10)
        
        self.leftLabel.text = left
        self.rightLabel.text = right
    }
    
    func tick(timer: NSTimer)
    {
        if --self.timeRemaining < 0
        {
            timer.invalidate()
        }
        else
        {
            self.updateLabels()
        }
    }

    func startTimers()
    {
        makeEmptyBars()
        
        // top bar (starting centered)
        self.bar1 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: TimerScene.TIMER_BAR_WIDTH))
        self.bar1.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar1)
        
        // right bar
        self.bar2 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: TimerScene.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame)))
        self.bar2.anchorPoint = CGPoint(x: 1, y: 1)
        self.bar2.position = CGPoint(x: CGRectGetWidth(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar2)
        
        // bottom bar
        self.bar3 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame), height: TimerScene.TIMER_BAR_WIDTH))
        self.bar3.anchorPoint = CGPoint(x: 1, y: 0)
        self.bar3.position = CGPoint(x: CGRectGetWidth(self.frame), y: 0)
        self.addChild(self.bar3)
        
        // left bar
        self.bar4 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: TimerScene.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame)))
        self.bar4.anchorPoint = CGPoint(x: 0, y: 0)
        self.bar4.position = CGPoint(x: 0, y: 0)
        self.addChild(self.bar4)
        
        // top bar (starting left)
        self.bar5 = SKSpriteNode(color: SKColor.gameGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: TimerScene.TIMER_BAR_WIDTH))
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

    private func makeEmptyBars()
    {
        // top bar (starting centered)
        self.bar1 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: TimerScene.TIMER_BAR_WIDTH))
        self.bar1.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame))
        self.addChild(self.bar1)
        
        // right bar
        self.bar2 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: TimerScene.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame) - TimerScene.TIMER_BAR_WIDTH * 2))
        self.bar2.anchorPoint = CGPoint(x: 1, y: 1)
        self.bar2.position = CGPoint(x: CGRectGetWidth(self.frame), y: CGRectGetHeight(self.frame) - TimerScene.TIMER_BAR_WIDTH)
        self.addChild(self.bar2)
        
        // bottom bar
        self.bar3 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame), height: TimerScene.TIMER_BAR_WIDTH))
        self.bar3.anchorPoint = CGPoint(x: 1, y: 0)
        self.bar3.position = CGPoint(x: CGRectGetWidth(self.frame), y: 0)
        self.addChild(self.bar3)
        
        // left bar
        self.bar4 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: TimerScene.TIMER_BAR_WIDTH, height: CGRectGetHeight(self.frame) - TimerScene.TIMER_BAR_WIDTH * 2))
        self.bar4.anchorPoint = CGPoint(x: 0, y: 0)
        self.bar4.position = CGPoint(x: 0, y: TimerScene.TIMER_BAR_WIDTH)
        self.addChild(self.bar4)
        
        // top bar (starting left)
        self.bar5 = SKSpriteNode(color: SKColor.gameLightGreyColor(), size: CGSize(width: CGRectGetWidth(self.frame) / 2, height: TimerScene.TIMER_BAR_WIDTH))
        self.bar5.anchorPoint = CGPoint(x: 0, y: 1)
        self.bar5.position = CGPoint(x: 0, y: CGRectGetHeight(self.frame))
        self.addChild(self.bar5)
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
        if scene == Scene.Playing
        {
            if let data = data, let scored = data["scored"] as? Bool
            {
                self.timer?.invalidate()
                self.timer = nil
                
                if scored
                {
                    // stop the timer bar from moving
                    self.bar1.removeAllActions()
                    self.bar2.removeAllActions()
                    self.bar3.removeAllActions()
                    self.bar4.removeAllActions()
                    self.bar5.removeAllActions()
                    
                    // give them a point
                    if self.blueTeam
                    {
                        TeamScoreView.sharedBlueInstance.addPointBar({ () -> Void in
                            updateStateFromData(.PassDevice, data: [ "blueTeam": !self.blueTeam ], currentScene: self)
                        })
                    }
                    else
                    {
                        TeamScoreView.sharedYellowInstance.addPointBar({ () -> Void in
                            updateStateFromData(.PassDevice, data: [ "blueTeam": !self.blueTeam ], currentScene: self)
                        })
                    }
                }
                else if let choosingScene = ChoosingScene(fileNamed: "ChoosingScene")
                {
                    choosingScene.blueTeam = !self.blueTeam
                    self.view?.presentScene(choosingScene, transition: SKTransition.fadeWithDuration(0.5))
                }
            }
        }
        else
        {
            updateStateFromData(scene, data: data, currentScene: self)
        }
    }
}