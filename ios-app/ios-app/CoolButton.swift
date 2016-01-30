//
//  CoolButton.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class CoolButton : SKSpriteNode
{
    // wrap the label's text
    var text: String?
    {
        get
        {
            return self.label.text
        }
        set
        {
            self.label.text = newValue
        }
    }
    
    // wrap the label's font color
    var fontColor: SKColor?
    {
        get
        {
            return self.label.fontColor
        }
        set
        {
            self.label.fontColor = fontColor
        }
    }
    
    private(set) var label = SKLabelNode(fontNamed: "STHeitiTC-Light")
    var buttonColor: SKColor
    var flatColor = false
    
    // used for linking any object to the button
    var tag: AnyObject?
    
    // store targets/selectors
    private var targets: [AnyObject] = [ ]
    private var selectors: [Selector] = [ ]
    
    init(color: SKColor, size: CGSize)
    {
        // save original color
        self.buttonColor = color
        
        super.init(texture: nil, color: color, size: size)
        
        // allow user interaction
        self.userInteractionEnabled = true
        
        // set font size and alignment
        self.label.fontSize = 18
        self.label.horizontalAlignmentMode = .Center
        self.label.verticalAlignmentMode = .Center
        
        // add the label
        self.addChild(self.label)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(target: AnyObject, selector: Selector)
    {
        self.targets.append(target)
        self.selectors.append(selector)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if !self.flatColor
        {
            self.color = self.buttonColor.colorWithSaturationFactor(1.25)
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?)
    {
        if !self.flatColor
        {
            self.color = self.buttonColor
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if !self.flatColor
        {
            self.color = self.buttonColor
        }
        
        for (index, target) in self.targets.enumerate()
        {
            target.performSelector(self.selectors[index], withObject: self)
        }
    }
}