//
//  WX_UserInfoModel.h
//  LXYWeChatDemo
//
//  Created by Echo on 8/27/15.
//  Copyright (c) 2015 Echo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int32_t, Gender_Type)
{
    Unknown = 0,
    Male = 1,
    FeMale = 2,
};

@interface WX_UserInfoModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *openid;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSArray *privilege;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *headimgurl;
@property (nonatomic, strong) NSString *unionid;
@property (nonatomic, assign) Gender_Type sex;
@property (nonatomic, strong) NSString *province;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
