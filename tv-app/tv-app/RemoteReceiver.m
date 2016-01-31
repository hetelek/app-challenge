//
//  RemoteReceiver.m
//  RemoteReceiver
//
//  Created by Vivian Aranha on 9/22/15.
//  Copyright © 2015 Vivian Aranha. All rights reserved.
//

#import "RemoteReceiver.h"
#import "GCDAsyncSocket.h"

#define SERVICE_NAME @"_probonjore._tcp."

@interface RemoteReceiver() <GCDAsyncSocketDelegate, NSNetServiceDelegate, NSNetServiceBrowserDelegate>

@property (strong, nonatomic) NSNetService *service;
@property (strong, nonatomic) GCDAsyncSocket *socket;
@property BOOL isConnected;

@end

@implementation RemoteReceiver

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.isConnected = NO;
        [self startBroadCasting];
    }
    
    return self;
}

-(void)startBroadCasting
{
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError* error = nil;
    if ([self.socket acceptOnPort:0 error:&error])
    {
        self.service =[[NSNetService alloc]initWithDomain:@"local." type:SERVICE_NAME name:@"poison" port:[self.socket localPort]];
        self.service.delegate=self;
        [self.service publish];
    }
}

- (void)netServiceDidPublish:(NSNetService *)service
{
//    NSLog(@"Bonjour Service Published: domain(%@) type(%@) name(%@) port(%i)", [service domain], [service type], [service name], (int)[service port]);
}

- (void)netService:(NSNetService *)service didNotPublish:(NSDictionary *)errorDict
{
//    NSLog(@"Failed to Publish Service: domain(%@) type(%@) name(%@) - %@", [service domain], [service type], [service name], errorDict);
}


-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    self.socket= newSocket;
    
    [self.socket readDataToLength:sizeof(uint64_t) withTimeout:-1.0f tag:0];
    
    NSData *data= [@"Connected" dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1.0f tag:0];
    
    self.isConnected = YES;
    [self.delegate connectivityStatusChanged:YES];
}


- (void)socketDidDisconnect:(GCDAsyncSocket *)socket withError:(NSError *)error
{
    if (self.socket == socket)
    {
        [self startBroadCasting];
        
        self.isConnected = NO;
        [self.delegate connectivityStatusChanged:NO];
    }
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    NSString *theTestString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if(!theTestString)
    {
        NSDictionary *myDictionary = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.delegate didReceiveMessage:myDictionary];
    }
    [sock readDataWithTimeout:-1.0f tag:0];
}
@end
