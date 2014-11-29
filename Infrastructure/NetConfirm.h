//
//  NetConfirm.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-2.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetConfirm : NSObject

typedef enum {
    ConnectionTypeNone,
    ConnectionTypeWiFi,
    ConnectionType3G
} ConnectionType;

+ (ConnectionType)connectionType;

@end
