//
//  ViewController.m
//  LXYWeChatDemo
//
//  Created by Echo on 8/27/15.
//  Copyright (c) 2015 Echo. All rights reserved.
//

#import "ViewController.h"
#import "Vendor_WeiXin.h"

@interface ViewController () <Vendor_WeiXinDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSArray *funcList;
@property (nonatomic, strong) NSArray *shareList;
@property (nonatomic, strong) NSArray *loginList;
@property (nonatomic, strong) NSArray *payList;

@property (nonatomic, assign) ShareMediaType ShareType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.shareList = [[NSArray alloc] initWithObjects:@"分享文字", @"分享图片", @"分享音频", @"分享视频", @"分享链接",nil];
    self.loginList = [[NSArray alloc] initWithObjects:@"登录", nil];
    self.payList = [[NSArray alloc] initWithObjects:@"支付", nil];
    self.funcList = [[NSArray alloc] initWithObjects:@"分享", @"登录", @"支付", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _funcList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _shareList.count;
            break;
        case 1:
            return _loginList.count;
            break;
        case 2:
            return _payList.count;
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [_shareList objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.textLabel.text = [_loginList objectAtIndex:indexPath.row];
            break;
        case 2:
            cell.textLabel.text = [_payList objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_funcList objectAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.ShareType = -1;
    //分享
    if (indexPath.section == 0) {
        self.ShareType = indexPath.row;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享目标" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信好友", @"朋友圈", @"收藏",nil];
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    //登录
    else if (indexPath.section == 1) {
        Vendor_WeiXin *wx = [Vendor_WeiXin sharedHandler];
        wx.delegate = self;
        [wx LoginWithWeChat];
    }
    //支付
    else if (indexPath.section == 2) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"即将开放" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ShareToolType type = 0;
    Vendor_WeiXin *wx = [Vendor_WeiXin sharedHandler];
    switch (buttonIndex) {
        case 0:
            type = kShareTool_WeiXinFriends;
            break;
        case 1:
            type = kShareTool_WeiXinCircleFriends;
            break;
        case 2:
            type = kShareTool_WeiXinCollection;
            break;
        default:
            break;
    }
    switch (self.ShareType) {
        case kShareMedia_WeiXinText:
            wx.text = @"share text";
            [wx shareInformationWithType:type ShareMediaType:self.ShareType Thumb_Image:nil];
            break;
        case kShareMedia_WeiXinImage:
            wx.title = @"title";
            wx.detailTitle = @"detailTitle";
            wx.ImageName = @"logo";
            [wx shareInformationWithType:type ShareMediaType:self.ShareType Thumb_Image:[UIImage imageNamed:@"logo"]];
            break;
        case kShareMedia_WeiXinMusic:
            wx.title = @"title";
            wx.detailTitle = @"detailTitle";
            wx.musicURL = @"http://7xldg1.com1.z0.glb.clouddn.com/wx好日子.mp3";
            wx.musicDataURL = @"http://7xldg1.com1.z0.glb.clouddn.com/wx好日子.mp3";
            [wx shareInformationWithType:type ShareMediaType:self.ShareType Thumb_Image:[UIImage imageNamed:@"logo"]];
            break;
        case kShareMedia_WeiXinVideo:
            wx.title = @"title";
            wx.detailTitle = @"detailTitle";
            wx.videoURL = @"http://www.idarex.com/tv/512";
            [wx shareInformationWithType:type ShareMediaType:self.ShareType Thumb_Image:[UIImage imageNamed:@"logo"]];
            break;
        case kShareMedia_WeiXinLink:
            wx.title = @"title";
            wx.detailTitle = @"detailTitle";
            wx.linkURL = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
            [wx shareInformationWithType:type ShareMediaType:self.ShareType Thumb_Image:[UIImage imageNamed:@"logo"]];
            break;
        default:
            break;
    }
}

#pragma mark - Vendor_WeiXinDelegate

-(void)getWeiXinLoginUserInfo:(WX_UserInfoModel *)userinfo
{
    NSLog(@"userinfo unionid:%@",userinfo.unionid);
}

@end
