//
//  RemoteSender.h
//  RemoteSender
//
//  Created by Vivian Aranha on 9/22/15.
//  Copyright © 2015 Vivian Aranha. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RemoteSenderDelegate <NSObject>

@required
- (void)connectivityStatusChanged:(BOOL)connected;

@end

@interface RemoteSender : NSObject
@property(nonatomic, weak) id<RemoteSenderDelegate> delegate;

- (void)sendInfo:(NSDictionary *)infoDict;
@end
