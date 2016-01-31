//
//  TeamScoreView.swift
//  tv-app
//
//  Created by Stevie Hetelekides on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

enum TeamColor
{
    case Yellow, Blue
}

class TeamScoreView : SKSpriteNode
{
    // constants
    private let MAGIC_HEIGHT_MULTIPLIER: CGFloat = 0.3259259259
    private let MAGIC_POINT_BAR_WIDTH_MULTIPLIER: CGFloat = 0.2341920375
    private let MAX_NUMBER_OF_POINT_BARS: CGFloat = 6
    private let TEAM_COLOR_FONT_SIZE: CGFloat = 80
    private let TEAM_FONT_SIZE: CGFloat = 50
    
    // instance variables
    private var pointBars: [SKSpriteNode] = [ ]
    
    // score stack
    var pointBarSize: CGSize
    var pointBarSeperation: CGFloat = 10
    
    // colors
    private(set) var teamColor: TeamColor
    private var primaryColor: SKColor
    private var secondaryColor: SKColor
    
    init(teamColor: TeamColor, width: CGFloat)
    {
        self.teamColor = teamColor
        
        // calculate frame size, and point bar size
        let height = UIScreen.mainScreen().bounds.height * self.MAGIC_HEIGHT_MULTIPLIER
        let size = CGSize(width: width, height: height)
        
        self.pointBarSize = CGSize(width: self.MAGIC_POINT_BAR_WIDTH_MULTIPLIER * width, height: height / self.MAX_NUMBER_OF_POINT_BARS - self.pointBarSeperation)
        
        // set color scheme
        if teamColor == .Yellow
        {
            self.primaryColor = SKColor.gameYellowColor()
            self.secondaryColor = SKColor.gameBlueColor()
            
            super.init(texture: nil, color: SKColor.gameYellowColor(), size: size)
            
            // add team color label
            let teamColorLabel = SKLabelNode(text: "BLUE")
            teamColorLabel.fontColor = self.secondaryColor
            teamColorLabel.fontSize = self.TEAM_COLOR_FONT_SIZE
            teamColorLabel.horizontalAlignmentMode = .Left
            teamColorLabel.position.x = self.pointBarSize.width + 10
            self.addChild(teamColorLabel)
            
            // add "Team" label
            let teamLabel = SKLabelNode(text: "Team")
            teamLabel.fontColor = self.secondaryColor
            teamLabel.fontSize = self.TEAM_FONT_SIZE
            teamLabel.horizontalAlignmentMode = .Left
            teamLabel.position.x = self.pointBarSize.width + 10
            teamLabel.position.y = CGRectGetHeight(teamColorLabel.frame) + 10
            self.addChild(teamLabel)
            
            // set anchor to bottom left (makes things easier)
            self.anchorPoint = CGPoint(x: 0, y: 0)
        }
        else
        {
            self.primaryColor = SKColor.gameBlueColor()
            self.secondaryColor = SKColor.gameYellowColor()
            
            super.init(texture: nil, color: SKColor.gameBlueColor(), size: size)
            
            // add team color label
            let teamColorLabel = SKLabelNode(text: "YELLOW")
            teamColorLabel.fontColor = self.secondaryColor
            teamColorLabel.fontSize = self.TEAM_COLOR_FONT_SIZE
            teamColorLabel.horizontalAlignmentMode = .Right
            teamColorLabel.position.x = -self.pointBarSize.width - 10
            self.addChild(teamColorLabel)
            
            // add "Team" label
            let teamLabel = SKLabelNode(text: "Team")
            teamLabel.fontColor = self.secondaryColor
            teamLabel.fontSize = self.TEAM_FONT_SIZE
            teamLabel.horizontalAlignmentMode = .Right
            teamLabel.position.x = -self.pointBarSize.width - 10
            teamLabel.position.y = CGRectGetHeight(teamColorLabel.frame) + 10
            self.addChild(teamLabel)
            
            // set anchor to bottom right (makes things easier)
            self.anchorPoint = CGPoint(x: 1, y: 0)
        }
    }
    
    func addPointBar()
    {
        // create bar and set anchor point to bottom left
        let pointBar = SKSpriteNode(color: self.secondaryColor, size: self.pointBarSize)
        pointBar.anchorPoint = self.anchorPoint
        
        // get the top bar, and set the new bar's y based off of that
        if let topBar = self.pointBars.last
        {
            pointBar.position.y = topBar.position.y + topBar.size.height + self.pointBarSeperation
        }
        
        self.pointBars.append(pointBar)
        self.addChild(pointBar)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}