//
//  MenuItem.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-11.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (nonatomic,retain) NSString* itemname;
@property (nonatomic,retain) NSString* imagename;
@property (nonatomic,retain) NSString* target;
@property (nonatomic,assign) BOOL      method;

@end
