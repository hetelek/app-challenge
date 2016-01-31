//
//  HiddenDetailPane.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/30/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

class TapToViewPane : SKSpriteNode
{
    
    // wrap the label's font color
    var fontColor: SKColor?
        {
        get
        {
            return self.label.fontColor
        }
        set
        {
            self.label.fontColor = newValue
        }
    }
    
    var unhiddenText: String = ""
    {
        didSet
        {
            // if the unhidden text should be showing, update the label
            if !self.isShowingHiddenText
            {
                updateLabelText()
            }
        }
    }
    
    var hiddenText: String = ""
    {
        didSet
        {
            // if the hidden text should be showing, update the label
            if self.isShowingHiddenText
            {
                updateLabelText()
            }
        }
    }
    
    private(set) var isShowingHiddenText = false
    {
        // update the label based on the state
        didSet
        {
            updateLabelText()
        }
    }
    
    private(set) var label = SKLabelNode(fontNamed: "STHeitiTC-Light")
    var paneColor: SKColor
    
    init(color: SKColor, size: CGSize)
    {
        self.paneColor = color
        
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.isShowingHiddenText = true
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?)
    {
        self.isShowingHiddenText = false
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.isShowingHiddenText = false
    }
    
    private func updateLabelText()
    {
        // get the text that should be showing
        let newText = self.isShowingHiddenText ? self.hiddenText : self.unhiddenText
        
        // if the label has no text, instantly do it
        if self.label.text == nil || self.label.text == ""
        {
            self.label.text = newText
        }
        else
        {
            // remove all actions (just in case they're hitting it really fast)
            self.label.removeAllActions()
            
            // fade it out, then back in with the new text
            self.label.runAction(SKAction.fadeOutWithDuration(0.15)) { () -> Void in
                self.label.text = newText
                
                self.label.runAction(SKAction.fadeInWithDuration(0.15))
            }
        }
    }
}