# LXYWeChatDemo


#iOS快速集成微信登录、分享


写在前面：

当前版本的不支持支付，后期会添加支付的方法。

#####首先按照微信iOS SDK接入，这里不再叙述。
> [微信SDK传送门](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417674108&token=649eccbe860e9dc1a8a54d28ee6686bbe04540fd&lang=zh_CN)

#####配置步骤：

###### 第一步：
![配置URL Scheme](http://ktwyuf.vanhorn-gd.diancloud.cn/content/images/2015/08/wx_01.png)

- 位置一：填写微信申请下来的AppId。
- 位置二：填写一个你的App的唯一标示，1k以内的字符串即可。（如果有登录需求的须填写，没有的可忽略）

###### 第二步：

![配置微信信息](http://ktwyuf.vanhorn-gd.diancloud.cn/content/images/2015/08/wx_02.png)

> - kTestWeiXinAppId:微信申请下来的AppId
> - kTestWeiXinSecret:微信申请下来的AppSecret
> - kTestSendState:与第一步位置二内容相同即可

#####使用方式：

- AppDelegate.m

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[Vendor_WeiXin sharedHandler] initWeiXin];
    return YES;
}
```
```
#pragma mark - WeiXin

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    //有登录需求的加上下面这句
    [[Vendor_WeiXin sharedHandler] accessWXAuthProgress:url];
    return  isSuc;
}
```
>分享途径

```
typedef enum {
    kShareTool_WeiXinFriends = 0, // 微信好友
    kShareTool_WeiXinCircleFriends, // 微信朋友圈
    kShareTool_WeiXinCollection, // 微信收藏
} ShareToolType;
```
>分享类型

```
typedef enum {
    kShareMedia_WeiXinText = 0, //文字
    kShareMedia_WeiXinImage, //图片
    kShareMedia_WeiXinMusic, //音频
    kShareMedia_WeiXinVideo, //视频
    kShareMedia_WeiXinLink, //链接
} ShareMediaType;
```

>获取使用微信登录的用户在微信里的信息

```
@protocol Vendor_WeiXinDelegate <NSObject>

-(void)getWeiXinLoginUserInfo:(WX_UserInfoModel *)userinfo;

@end
```