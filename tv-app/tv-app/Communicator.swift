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
    func receivedData(data: [String: AnyObject])
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
        if let data = userInfo as? [String: AnyObject]
        {
            self.delegate?.receivedData(data)
        }
    }
}
