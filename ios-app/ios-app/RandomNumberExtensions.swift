//
//  NumberExtensions.swift
//  BestColor
//
//  Created by Stevie Hetelekides on 9/15/15.
//  Copyright (c) 2015 Expetelek. All rights reserved.
//

import Foundation
import UIKit

public extension Int
{
    public static func random(upperBound: Int) -> Int
    {
        return Int(arc4random_uniform(UInt32(upperBound)))
    }
    
    public static func random(min min: Int, max: Int) -> Int
    {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}

public extension Double
{
    public static func random() -> Double
    {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    public static func random(min min: Double, max: Double) -> Double
    {
        return Double.random() * (max - min) + min
    }
}

public extension CGFloat
{
    public static func random() -> CGFloat
    {
        return CGFloat(arc4random()) / 0x7FFFFFFF
    }
    
    public static func random(min min: CGFloat, max: CGFloat) -> CGFloat
    {
        return CGFloat.random() * (max - min) + min
    }
}
