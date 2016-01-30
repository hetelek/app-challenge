//
//  Team.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/30/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import Foundation

enum TeamColor
{
    case Yellow, Blue
}

class Team
{
    private(set) var teamColor: TeamColor
    var score: Int = 0
    
    init(teamColor: TeamColor)
    {
        self.teamColor = teamColor
    }
}