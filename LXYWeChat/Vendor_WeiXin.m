//
//  Vendor_WeiXin.m
//  LXYWeChatDemo
//
//  Created by Echo on 8/27/15.
//  Copyright (c) 2015 Echo. All rights reserved.
//

#import "Vendor_WeiXin.h"

#define kTestWeiXinAppId @""
#define kTestWeiXinSecret @""
#define kTestSendState @""

@implementation Vendor_WeiXin

@synthesize text = _text;
@synthesize title = _title;
@synthesize detailTitle = _detailTitle;
@synthesize thumb_ImageName = _thumb_ImageName;
@synthesize thumb_ImageFilePath = _thumb_ImageFilePath;
@synthesize ImageName = _ImageName;
@synthesize ImageURL = _ImageURL;
@synthesize ImageFilePath = _ImageFilePath;
@synthesize linkURL = _linkURL;
@synthesize musicDataURL = _musicDataURL;
@synthesize musicURL = _musicURL;
@synthesize videoURL = _videoURL;

+(instancetype)sharedHandler
{
    static Vendor_WeiXin *_sharedHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHandler = [[Vendor_WeiXin alloc] init];
    });
    return _sharedHandler;
}

#pragma mark - 注册微信

-(void)initWeiXin
{
    [WXApi registerApp:kTestWeiXinAppId];
}

#pragma mark - 用微信登录

-(void)LoginWithWeChat
{
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = kTestSendState; //自定义一个字符串1k以内即可，在app里配置一个URL Schemes。
    [WXApi sendReq:req];
}

-(void)accessWXAuthProgress:(NSURL *)openURL
{
    NSArray *codeArray = [[openURL absoluteString] componentsSeparatedByString:@"?"];
    
    NSArray *spc = [[codeArray firstObject] componentsSeparatedByString:@"://"];
    if ([[spc lastObject] isEqualToString:@"oauth"]) {
        NSString *queryString = [codeArray lastObject];
        NSArray *queryArray = [queryString componentsSeparatedByString:@"&"];
        NSString *codeString = [queryArray firstObject];
        NSArray *Array = [codeString componentsSeparatedByString:@"="];
        if ([[Array firstObject] isEqualToString:@"code"]) {
            [self getAccessToken:[Array lastObject]];
        }
    }
}

-(void)getAccessToken:(NSString *)code
{
    //WeiXinAppId 为微信申请的appid
    //WeiXinSecret 为微信申请的appSecret
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kTestWeiXinAppId,kTestWeiXinSecret,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *access_token = [dic objectForKey:@"access_token"];
                NSString *openid = [dic objectForKey:@"openid"];
                [self getUserInfo_accessToken:access_token openid:openid];
            }
        });
    });
}

-(void)getUserInfo_accessToken:(NSString *)accessToken openid:(NSString *)openid
{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                WX_UserInfoModel *model = [WX_UserInfoModel modelObjectWithDictionary:dic];
                [self.delegate getWeiXinLoginUserInfo:model];
            }
        });
        
    });
}

#pragma mark - 微信分享

- (void)shareInformationWithType:(ShareToolType)shareToolType ShareMediaType:(ShareMediaType)ShareMediaType Thumb_Image:(UIImage *)Thumb_Image
{
    ShareToolType scene = shareToolType;
    switch (ShareMediaType) {
        case kShareMedia_WeiXinText:
        {
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.text = self.text;
            req.bText = YES;
            req.scene = scene;
            [WXApi sendReq:req];
            break;
        }
        case kShareMedia_WeiXinImage:
        {
            WXMediaMessage *message = [WXMediaMessage message];
            [message setThumbImage:Thumb_Image];
            
            WXImageObject *ext = [WXImageObject object];
            
            if (self.ImageURL != nil) {
                ext.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.ImageURL]];
            }
            else if (self.ImageFilePath != nil) {
                ext.imageData = [NSData dataWithContentsOfFile:self.ImageFilePath];
            }
            else if (self.ImageName != nil) {
                UIImage* image = [UIImage imageNamed:self.ImageName];
                ext.imageData = UIImagePNGRepresentation(image);
            }
            
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = scene;
            
            [WXApi sendReq:req];
            break;
        }
        case kShareMedia_WeiXinMusic:
        {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = self.title;
            message.description = self.detailTitle;
            
            [message setThumbImage:Thumb_Image];
            
            WXMusicObject *ext = [WXMusicObject object];
            ext.musicUrl = self.musicURL;
            ext.musicDataUrl = self.musicDataURL;
            
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = scene;
            
            [WXApi sendReq:req];
            break;
        }
        case kShareMedia_WeiXinVideo:
        {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = self.title;
            message.description = self.detailTitle;
            
            [message setThumbImage:Thumb_Image];
            
            WXVideoObject *ext = [WXVideoObject object];
            ext.videoUrl = self.videoURL;
            
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = scene;
            
            [WXApi sendReq:req];
            break;
        }
        case kShareMedia_WeiXinLink:
        {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = self.title;
            message.description = self.detailTitle;
            
            [message setThumbImage:Thumb_Image];
            
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = self.linkURL;
            
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = scene;
            
            [WXApi sendReq:req];
            break;
        }
        default:
            break;
    }
    
    
}

@end
