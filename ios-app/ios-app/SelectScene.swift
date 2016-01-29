//
//  SelectScreen.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class SelectScene : SKScene
{
    var buttonTitles: [String] = [ ]
    private var contentCreated = false
    
    private let HORIZONTAL_SPACING: CGFloat = 20
    private let VERTICAL_SPACING: CGFloat = 20
    
    override func didMoveToView(view: SKView)
    {
        // create the content if we haven't already
        if !self.contentCreated
        {
            createContent()
            self.contentCreated = true
        }
    }
    
    private func createContent()
    {
        // set background color/scale
        self.backgroundColor = SKColor.greenColor()
        self.scaleMode = .ResizeFill
        
        // screen center
        let centerX = CGRectGetMidX(self.frame)
        let centerY = CGRectGetMidY(self.frame)
        
        // button size
        let width = centerX - self.HORIZONTAL_SPACING
        let height = centerY - self.VERTICAL_SPACING
        
        // calculate spacing
        let horizontalSpacing: CGFloat = width + self.HORIZONTAL_SPACING * 0.75
        let verticalSpacing: CGFloat = height + self.VERTICAL_SPACING * 0.75
        
        // create btutons
        let spacing: [[CGFloat]] = [ [-1, 1], [1, 1], [-1, -1], [1, -1] ]
        for (index, buttonTitle) in self.buttonTitles.enumerate()
        {
            // create start button
            let button = CoolButton(color: UIColor.blackColor(), size: CGSize(width: width, height: height))
            button.text = buttonTitle
            button.addTarget(self, selector: "optionSelected:")
            
            // calculate points
            let x = centerX + spacing[index][0] * (horizontalSpacing / 2)
            let y = centerY + spacing[index][1] * (verticalSpacing / 2)
            button.position = CGPoint(x: x, y: y)
            
            // add button to scene
            self.addChild(button)
        }
    }
    
    func optionSelected(button: CoolButton)
    {
        if let selectScreen = SelectScene(fileNamed: "SelectScene")
        {
            // set button titles
            selectScreen.buttonTitles = [ "No arms", "Eyes closed", "No talking", "Facing the other way" ]
            
            self.view?.presentScene(selectScreen, transition: SKTransition.doorsCloseHorizontalWithDuration(0.5))
        }
    }
}