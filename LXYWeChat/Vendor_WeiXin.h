//
//  Vendor_WeiXin.h
//  LXYWeChatDemo
//
//  Created by Echo on 8/27/15.
//  Copyright (c) 2015 Echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WX_UserInfoModel.h"

typedef enum {
    kShareTool_WeiXinFriends = 0, // 微信好友
    kShareTool_WeiXinCircleFriends, // 微信朋友圈
    kShareTool_WeiXinCollection, // 微信收藏
} ShareToolType;

typedef enum {
    kShareMedia_WeiXinText = 0, //文字
    kShareMedia_WeiXinImage, //图片
    kShareMedia_WeiXinMusic, //音频
    kShareMedia_WeiXinVideo, //视频
    kShareMedia_WeiXinLink, //链接
} ShareMediaType;

@protocol Vendor_WeiXinDelegate <NSObject>

-(void)getWeiXinLoginUserInfo:(WX_UserInfoModel *)userinfo;

@end

@interface Vendor_WeiXin : NSObject

@property (nonatomic, weak) id<Vendor_WeiXinDelegate> delegate;
@property (nonatomic, strong, readwrite) NSString *text;
@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSString *detailTitle;
@property (nonatomic, strong, readwrite) NSString *thumb_ImageName;
@property (nonatomic, strong, readwrite) NSString *thumb_ImageFilePath;
@property (nonatomic, strong, readwrite) NSString *ImageName;
@property (nonatomic, strong, readwrite) NSString *ImageURL;
@property (nonatomic, strong, readwrite) NSString *ImageFilePath;
@property (nonatomic, strong, readwrite) NSString *linkURL;
@property (nonatomic, strong, readwrite) NSString *videoURL;
@property (nonatomic, strong, readwrite) NSString *musicURL;
@property (nonatomic, strong, readwrite) NSString *musicDataURL;

+(instancetype)sharedHandler;

-(void)initWeiXin;

-(void)LoginWithWeChat;

-(void)accessWXAuthProgress:(NSURL *)openURL;

- (void)shareInformationWithType:(ShareToolType)shareToolType ShareMediaType:(ShareMediaType)ShareMediaType Thumb_Image:(UIImage *)Thumb_Image;


@end
