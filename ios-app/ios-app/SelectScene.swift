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
    private var contentCreated = false
    
    let buttonColors = [ SKColor.gameBlueColor(), SKColor.gameYellowColor(), SKColor.gameYellowColor(), SKColor.gameBlueColor() ]
    let fontColors = [ SKColor.gameYellowColor(), SKColor.gameBlueColor(), SKColor.gameBlueColor(), SKColor.gameYellowColor() ]
    
    // state variables
    var state: SelectSceneState = .SelectChoice
    
    // button spacing
    private let HORIZONTAL_SPACING: CGFloat = 0
    private let VERTICAL_SPACING: CGFloat = 0
    
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
            self.setupSelectModifierGUI()
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
            let button = CoolButton(color: self.buttonColors[index], size: CGSize(width: width, height: height))
            button.fontColor = self.fontColors[index]
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
    
    private func setupSelectModifierGUI()
    {
        if let selectedChoice = Game.sharedInstance.selectedChoice
        {
            // screen center
            let centerX = CGRectGetMidX(self.frame)
            
            // calcualte width and height of each button
            let width = self.frame.size.width - HORIZONTAL_SPACING * 2
            let height = self.frame.size.height / 2 - VERTICAL_SPACING * 1.5
            
            // calculate y coordinate (relative from edge of screen)
            let y = HORIZONTAL_SPACING + height / 2
            
            // create top button
            let topButton = CoolButton(color: SKColor.gameYellowColor(), size: CGSize(width: width, height: height))
            topButton.fontColor = SKColor.gameBlueColor()
            topButton.position = CGPoint(x: centerX, y: self.frame.height - y)
            topButton.text = selectedChoice.modifiers[0].modifierOnly
            topButton.tag = selectedChoice.modifiers[0]
            topButton.addTarget(self, selector: "optionSelected:")
            
            // create bottom button
            let bottomButton = CoolButton(color: SKColor.gameBlueColor(), size: CGSize(width: width, height: height))
            bottomButton.fontColor = SKColor.gameYellowColor()
            bottomButton.position = CGPoint(x: centerX, y: y)
            bottomButton.text = selectedChoice.modifiers[1].modifierOnly
            bottomButton.tag = selectedChoice.modifiers[1]
            bottomButton.addTarget(self, selector: "optionSelected:")
            
            // add buttons to view
            self.addChild(topButton)
            self.addChild(bottomButton)
        }
    }
    
    func optionSelected(button: CoolButton)
    {
        if self.state == .SelectChoice
        {
            if let choice = button.tag as? Choice, let selectScreen = SelectScene(fileNamed: "SelectScene")
            {
                // select choice
                Game.sharedInstance.selectChoice(choice)
                
                // set new state
                selectScreen.state = .SelectModifier
                
                // present new scene (same class but with "Select Modifier" state)
                self.view?.presentScene(selectScreen, transition: SKTransition.fadeWithDuration(0.5))
            }
        }
        else if self.state == .SelectModifier
        {
            // proceed to next screen
            if let modifier = button.tag as? Modifier, let passDeviceScene = PassDeviceScene(fileNamed: "PassDeviceScene")
            {
                // select modifier
                Game.sharedInstance.selectModifier(modifier)
                
                // present next screen
                self.view?.presentScene(passDeviceScene, transition: SKTransition.fadeWithDuration(0.5))
            }
        }
    }
}