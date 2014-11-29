//
//  AppConfig.h
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#ifndef AdvertiseWall_AppConfig_h
#define AdvertiseWall_AppConfig_h

#define AppVersion @"版本：1.0.4"
#define AdvertiseWallUnit @"积分"
#define AVCloudProductionMode NO
#define AppID @"9fkigptnm2gjew8v7nskvpa9j1flisjp7tz1cjfsp2aoax4r"
#define AppKey @"k0w18zeovqgl2qjf25l48jg8ev6jksn1ynlxgabuly7evk9a"
//果盟 真
#define GuoMobAppID @"tn20i3pcrex5306"
//多盟 真
#define DMOfferAppID @"96ZJ3MUgzee0HwTCmE"
#define DMOfferUserID @"321fdsf"
//有米
#define YouMiAppID @"6191437ca20f2a14"
#define YouMiAppSecret @"45e2b6f1f2a6ef2b"
//安沃
#define ZKcmone_PID @"a48d4e9494064ab48e553fc04f82f32b"
#define ZKcmone_KEY @"normal"
//点乐 真
#define JJSessionID @"c1c9e4966172e8dd5342de3f4de8c4b7"
#define JJUserID @"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
//易积分 真
#define EscoreAppID @"73939"
#define EscoreDevID @"83050"
#define EscoreAppKey @"EMA2GWXS6HY421172BSINEYT5JPMSX18ZN"
#define EscoreChannel @"IOS2.0"
//米迪 真
#define MiidiAppID @"20204"
#define MiidiAppSecret @"5oegwh55gyrxzj8u"
//快友 聚合 无
#define AdWallAppID @"SDK20131517030700twbre5u5e4zpu64"
//鹰眼 真
#define AppemsAppID @"1aa5208fba4f1b55c72c25fd543bf93b"
//点入 不让接入
#define DianRuAppKey @"00002D1B190000F9"
//指盟 真
#define ZhiMengAppKey @"d25c76bfcf7fc702d6e3ef491dfa7589"

#define INITTITLESTRING @"开始中心"
#define TASKTITLESTRING @"任务中心"
#define MEMBERTITLESTRING @"个人账号"
#define EXCHANGETITLESTRING @"兑现中心"
#define SYSTEMTITLESTRING @"系统消息"

#define LOCALUSERNAMEKEY @"username"
#define LOCALPASSWORDKEY @"password"
#define LOCALAUTOLOGINKEY @"autologin"

#define ApplicationPool @"http://dev.advertiseshare.avosapps.com"
#define WebIpAddressMethod @"ipaddress"

#define TABBATHEADHEIGHT 30
#define kTaskScrollViewTag 2000

#define RGBColorMake(_R_,_G_,_B_,_alpha_) [UIColor colorWithRed:_R_/255.0 green:_G_/255.0 blue:_B_/255.0 alpha:_alpha_]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define GUOMOBNAME @"果盟"
#define GUOMOBTITLE @"果盟 积分墙"
#define GUOMOBFLAG 1
#define DOMOBNAME @"多盟"
#define DOMOBTITLE @"多盟 积分墙"
#define DOMOBFLAG 2
#define YOUMINAME @"有米"
#define YOUMITITLE @"有米 积分墙"
#define YOUMIFLAG 3
#define MIIDINAME @"米迪"
#define MIIDITITLE @"米迪 积分墙"
#define MIIDIFLAG 4
#define ADWONAME @"安沃"
#define ADWOTITLE @"安沃 积分墙"
#define ADWOFLAG 5
#define ADWALLNAME @"快友"
#define ADWALLTITLE @"快友 积分墙"
#define ADWALLFLAG 6
#define DIANJOYNAME @"点乐"
#define DIANJOYTITLE @"点乐 积分墙"
#define DIANJOYFLAG 7
#define ESOCRENAME @"易积分"
#define ESOCRETITLE @"易积分 积分墙"
#define ESOCREFLAG 8
#define APPEMSNAME @"鹰眼"
#define APPEMSTITLE @"鹰眼 积分墙"
#define APPEMSFLAG 9
#define ZHIMENGNAME @"指盟"
#define ZHIMENGTITLE @"指盟 积分墙"
#define ZHIMENGFLAG 10

#define TERRACETOTAL 11

#endif
