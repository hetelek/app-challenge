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

class Communicator : NSObject, RemoteSenderDelegate
{
    static let sharedInstance = Communicator()
    
    var delegate: CommunicatorDelegate?
    private var sender: RemoteSender!
    
    override init()
    {
        super.init()
        
        self.sender = RemoteSender()
        self.sender.delegate = self
    }
    
    func sendData(data: [String: AnyObject])
    {
        self.sender.sendInfo(data)
    }
    
    @objc func connectivityStatusChanged(connected: Bool)
    {
        self.delegate?.connectivityStatusChanged(connected)
    }
}
