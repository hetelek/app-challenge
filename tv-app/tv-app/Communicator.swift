//
//  Communicator.swift
//  tv-app
//
//  Created by Stevie Hetelekides on 1/31/16.
//  Copyright © 2016 RyanDannyStevie. All rights reserved.
//

import Foundation

protocol CommunicatorProtocol
{
    func connectivityStatusChanged(connected: Bool)
    func receivedData(scene: Scene, data: [String: AnyObject]?)
}

enum Scene : Int
{
    case Menu, SelectChoice, SelectModifier, PassDevice, Start, Playing, ResetAll
}

class Communicator : NSObject, RemoteReceiverDelegate
{
    static let sharedInstance = Communicator()
    
    var delegate: CommunicatorProtocol?
    private var reciever: RemoteReceiver!
    
    override init()
    {
        super.init()
        
        self.reciever = RemoteReceiver()
        self.reciever.delegate = self
    }
    
    @objc func connectivityStatusChanged(connected: Bool)
    {
        self.delegate?.connectivityStatusChanged(connected)
    }
    
    @objc func didReceiveMessage(userInfo: [NSObject : AnyObject]!)
    {
        // parse the full dictionary
        if let fullData = userInfo as? [String: AnyObject]
        {
            // parse the scene
            if let sceneRawValue = fullData["scene"] as? Int, let scene = Scene(rawValue: sceneRawValue)
            {
                // call the delegate
                self.delegate?.receivedData(scene, data: fullData["data"] as? [String: AnyObject])
            }
            else
            {
                print("received weird stuff")
            }
        }
    }
}
