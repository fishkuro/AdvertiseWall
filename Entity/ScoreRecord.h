//
//  ScoreRecord.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-5.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface ScoreRecord : AVObject<AVSubclassing>

@property (nonatomic,retain) NSDate     *recordtime;
@property (nonatomic,retain) NSString   *userid;
@property (nonatomic,retain) NSString   *username;
//@property (nonatomic,retain) NSString   *taskid;
@property (nonatomic,retain) NSString   *taskname;
//@property (nonatomic,retain) NSString   *terraceid;
@property (nonatomic,retain) NSString   *terracename;
@property (nonatomic,retain) NSString   *appname;
//@property (nonatomic,retain) NSString   *adtype;
@property (nonatomic,retain) NSNumber   *adpoint;  //int
//@property (nonatomic,retain) NSNumber   *advalid;  //bool
@property (nonatomic,retain) NSString   *recordip;

@end
