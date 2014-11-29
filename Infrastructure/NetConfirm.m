//
//  NetConfirm.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-2.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "NetConfirm.h"
#import "Reachability.h"

@implementation NetConfirm

+ (ConnectionType)connectionType {
    ConnectionType connectionType = ConnectionTypeNone;
    Reachability *r = [Reachability reachabilityWithHostname:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            connectionType = ConnectionTypeNone;
            break;
        case ReachableViaWiFi:
            connectionType = ConnectionTypeWiFi;
            break;
        case ReachableViaWWAN:
            connectionType = ConnectionType3G;
            break;
        default:
            break;
    }
    return connectionType;
}

@end
