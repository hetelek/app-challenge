//
//  Communicator.swift
//  ios-app
//
//  Created by Stevie Hetelekides on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate
{
    func connectivityStatusChanged(connected: Bool)
}

enum Scene : Int
{
    case Menu, SelectChoice, SelectModifier, PassDevice, Start, Playing, ResetAll
}

class Communicator : NSObject, RemoteSenderDelegate
{
    static let sharedInstance = Communicator()
    
    var delegate: CommunicatorDelegate?
    private(set) var isConnected = false
    private var sender: RemoteSender!
    
    override init()
    {
        super.init()
        
        self.sender = RemoteSender()
        self.sender.delegate = self
    }
    
    func sendData(scene: Scene, data: [String: AnyObject]?)
    {
        if let data = data
        {
            self.sender.sendInfo([ "scene": scene.rawValue, "data": data ])
        }
        else
        {
            self.sender.sendInfo([ "scene": scene.rawValue ])
        }
    }
    
    @objc func connectivityStatusChanged(connected: Bool)
    {
        self.isConnected = connected
        self.delegate?.connectivityStatusChanged(connected)
    }
}
