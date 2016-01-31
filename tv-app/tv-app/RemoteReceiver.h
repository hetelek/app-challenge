//
//  RemoteReceiver.h
//  RemoteReceiver
//
//  Created by Vivian Aranha on 9/22/15.
//  Copyright © 2015 Vivian Aranha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RemoteReceiverDelegate <NSObject>

@required
- (void)didReceiveMessage:(NSDictionary *)userInfo;
- (void)connectivityStatusChanged:(BOOL)connected;
@end

@interface RemoteReceiver : NSObject
@property(nonatomic, weak) id<RemoteReceiverDelegate> delegate;
@end
