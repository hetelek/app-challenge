//
//  ColorExtensions.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import SpriteKit

extension SKColor
{
    class func gameBlueColor() -> SKColor
    {
        return SKColor(red: 0.2470588235, green: 0.6901960784, blue: 0.6745098039, alpha: 1)
    }
    
    class func gameYellowColor() -> SKColor
    {
        return SKColor(red: 0.9803921569, green: 0.8980392157, blue: 0.5882352941, alpha: 1)
    }
    
    class func gameGreyColor() -> SKColor
    {
        return SKColor(red: 0.09019607843, green: 0.2431372549, blue: 0.262745098, alpha: 1)
    }
    
    class func colorWithRGB(rgbValue: UInt, alpha: CGFloat = 1.0) -> SKColor
    {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        
        return SKColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func lighten(percent : Double) -> SKColor
    {
        return self.colorWithBrightnessFactor(CGFloat(1 + percent))
    }
    
    func darken(percent : Double) -> SKColor
    {
        return self.colorWithBrightnessFactor(CGFloat(1 - percent))
    }
    
    func colorWithBrightnessFactor(factor: CGFloat) -> SKColor
    {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        {
            return SKColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
        }
        else
        {
            return self
        }
    }
    
    func colorWithSaturationFactor(factor: CGFloat) -> SKColor
    {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        {
            return SKColor(hue: hue, saturation: saturation * factor, brightness: brightness, alpha: alpha)
        }
        else
        {
            return self
        }
    }
}