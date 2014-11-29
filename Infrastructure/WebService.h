//
//  WebService.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-2.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServicesConnection.h"

@interface WebService : NSObject<WebServicesDelegate>

- (void)asyncGetIpAddress;

@end
