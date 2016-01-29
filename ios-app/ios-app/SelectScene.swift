//
//  SelectScreen.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

enum SelectSceneState
{
    case SelectChoice, SelectModifier
}

class SelectScene : SKScene
{
    // button stuff
    private var buttonTitles: [String] = [ ]
    private var contentCreated = false
    
    // state variables
    var state: SelectSceneState = .SelectChoice
    var selectedChoice: Choice?
    
    // button spacing
    private let HORIZONTAL_SPACING: CGFloat = 20
    private let VERTICAL_SPACING: CGFloat = 20
    
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
        
        // setup GUI based on the state
        if self.state == .SelectChoice
        {
            self.steupSelectChoiceGUI()
        }
        else if self.state == .SelectModifier
        {
            self.steupSelectModifierGUI()
        }
    }
    
    private func steupSelectChoiceGUI()
    {
        // screen center
        let centerX = CGRectGetMidX(self.frame)
        let centerY = CGRectGetMidY(self.frame)
        
        // button size
        let width = centerX - self.HORIZONTAL_SPACING
        let height = centerY - self.VERTICAL_SPACING
        
        // calculate spacing
        let horizontalSpacing: CGFloat = width + self.HORIZONTAL_SPACING * 0.75
        let verticalSpacing: CGFloat = height + self.VERTICAL_SPACING * 0.75
        
        // get random choices
        let choices = Game.sharedInstance.randomChoices()
        
        // create buttons
        let spacing: [[CGFloat]] = [ [-1, 1], [1, 1], [-1, -1], [1, -1] ]
        for (index, choice) in choices.enumerate()
        {
            // create start button
            let button = CoolButton(color: UIColor.blackColor(), size: CGSize(width: width, height: height))
            button.text = choice.choice
            button.tag = choice
            button.addTarget(self, selector: "optionSelected:")
            
            // calculate points
            let x = centerX + spacing[index][0] * (horizontalSpacing / 2)
            let y = centerY + spacing[index][1] * (verticalSpacing / 2)
            button.position = CGPoint(x: x, y: y)
            
            // add button to scene
            self.addChild(button)
        }
    }
    
    private func steupSelectModifierGUI()
    {
        
    }
    
    func optionSelected(button: CoolButton)
    {
        if self.state == .SelectChoice
        {
            if let choice = button.tag as? Choice, let selectScreen = SelectScene(fileNamed: "SelectScene")
            {
                // set new state
                selectScreen.state = .SelectModifier
                selectScreen.selectedChoice = choice
                
                // present new scene (same class but with "Select Modifier" state)
                self.view?.presentScene(selectScreen, transition: SKTransition.fadeWithDuration(0.5))
            }
        }
        else if self.state == .SelectModifier
        {
            // proceed to next screen
        }
    }
}