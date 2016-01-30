//
//  ColorExtensions.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/29/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import UIKit

extension UIColor
{
    class func colorWithRGB(rgbValue : UInt, alpha : CGFloat = 1.0) -> UIColor
    {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func lighten(percent : Double) -> UIColor
    {
        return colorWithBrightnessFactor(CGFloat(1 + percent))
    }
    
    func darken(percent : Double) -> UIColor
    {
        return colorWithBrightnessFactor(CGFloat(1 - percent))
    }
    
    func colorWithBrightnessFactor(factor: CGFloat) -> UIColor
    {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
        }
        else
        {
            return self
        }
    }
}