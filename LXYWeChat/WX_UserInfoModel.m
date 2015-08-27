//
//  WX_UserInfoModel.m
//  LXYWeChatDemo
//
//  Created by Echo on 8/27/15.
//  Copyright (c) 2015 Echo. All rights reserved.
//

#import "WX_UserInfoModel.h"


NSString *const kWX_UserInfoModelOpenid = @"openid";
NSString *const kWX_UserInfoModelCity = @"city";
NSString *const kWX_UserInfoModelCountry = @"country";
NSString *const kWX_UserInfoModelNickname = @"nickname";
NSString *const kWX_UserInfoModelPrivilege = @"privilege";
NSString *const kWX_UserInfoModelLanguage = @"language";
NSString *const kWX_UserInfoModelHeadimgurl = @"headimgurl";
NSString *const kWX_UserInfoModelUnionid = @"unionid";
NSString *const kWX_UserInfoModelSex = @"sex";
NSString *const kWX_UserInfoModelProvince = @"province";


@interface WX_UserInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WX_UserInfoModel

@synthesize openid = _openid;
@synthesize city = _city;
@synthesize country = _country;
@synthesize nickname = _nickname;
@synthesize privilege = _privilege;
@synthesize language = _language;
@synthesize headimgurl = _headimgurl;
@synthesize unionid = _unionid;
@synthesize sex = _sex;
@synthesize province = _province;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.openid = [self objectOrNilForKey:kWX_UserInfoModelOpenid fromDictionary:dict];
            self.city = [self objectOrNilForKey:kWX_UserInfoModelCity fromDictionary:dict];
            self.country = [self objectOrNilForKey:kWX_UserInfoModelCountry fromDictionary:dict];
            self.nickname = [self objectOrNilForKey:kWX_UserInfoModelNickname fromDictionary:dict];
            self.privilege = [self objectOrNilForKey:kWX_UserInfoModelPrivilege fromDictionary:dict];
            self.language = [self objectOrNilForKey:kWX_UserInfoModelLanguage fromDictionary:dict];
            self.headimgurl = [self objectOrNilForKey:kWX_UserInfoModelHeadimgurl fromDictionary:dict];
            self.unionid = [self objectOrNilForKey:kWX_UserInfoModelUnionid fromDictionary:dict];
            self.sex = [[self objectOrNilForKey:kWX_UserInfoModelSex fromDictionary:dict] intValue];
            self.province = [self objectOrNilForKey:kWX_UserInfoModelProvince fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.openid forKey:kWX_UserInfoModelOpenid];
    [mutableDict setValue:self.city forKey:kWX_UserInfoModelCity];
    [mutableDict setValue:self.country forKey:kWX_UserInfoModelCountry];
    [mutableDict setValue:self.nickname forKey:kWX_UserInfoModelNickname];
    NSMutableArray *tempArrayForPrivilege = [NSMutableArray array];
    for (NSObject *subArrayObject in self.privilege) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPrivilege addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPrivilege addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPrivilege] forKey:kWX_UserInfoModelPrivilege];
    [mutableDict setValue:self.language forKey:kWX_UserInfoModelLanguage];
    [mutableDict setValue:self.headimgurl forKey:kWX_UserInfoModelHeadimgurl];
    [mutableDict setValue:self.unionid forKey:kWX_UserInfoModelUnionid];
    [mutableDict setValue:[NSNumber numberWithInt:self.sex] forKey:kWX_UserInfoModelSex];
    [mutableDict setValue:self.province forKey:kWX_UserInfoModelProvince];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.openid = [aDecoder decodeObjectForKey:kWX_UserInfoModelOpenid];
    self.city = [aDecoder decodeObjectForKey:kWX_UserInfoModelCity];
    self.country = [aDecoder decodeObjectForKey:kWX_UserInfoModelCountry];
    self.nickname = [aDecoder decodeObjectForKey:kWX_UserInfoModelNickname];
    self.privilege = [aDecoder decodeObjectForKey:kWX_UserInfoModelPrivilege];
    self.language = [aDecoder decodeObjectForKey:kWX_UserInfoModelLanguage];
    self.headimgurl = [aDecoder decodeObjectForKey:kWX_UserInfoModelHeadimgurl];
    self.unionid = [aDecoder decodeObjectForKey:kWX_UserInfoModelUnionid];
    self.sex = [aDecoder decodeIntForKey:kWX_UserInfoModelSex];
    self.province = [aDecoder decodeObjectForKey:kWX_UserInfoModelProvince];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_openid forKey:kWX_UserInfoModelOpenid];
    [aCoder encodeObject:_city forKey:kWX_UserInfoModelCity];
    [aCoder encodeObject:_country forKey:kWX_UserInfoModelCountry];
    [aCoder encodeObject:_nickname forKey:kWX_UserInfoModelNickname];
    [aCoder encodeObject:_privilege forKey:kWX_UserInfoModelPrivilege];
    [aCoder encodeObject:_language forKey:kWX_UserInfoModelLanguage];
    [aCoder encodeObject:_headimgurl forKey:kWX_UserInfoModelHeadimgurl];
    [aCoder encodeObject:_unionid forKey:kWX_UserInfoModelUnionid];
    [aCoder encodeInt:_sex forKey:kWX_UserInfoModelSex];
    [aCoder encodeObject:_province forKey:kWX_UserInfoModelProvince];
}

- (id)copyWithZone:(NSZone *)zone
{
    WX_UserInfoModel *copy = [[WX_UserInfoModel alloc] init];
    
    if (copy) {

        copy.openid = [self.openid copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.nickname = [self.nickname copyWithZone:zone];
        copy.privilege = [self.privilege copyWithZone:zone];
        copy.language = [self.language copyWithZone:zone];
        copy.headimgurl = [self.headimgurl copyWithZone:zone];
        copy.unionid = [self.unionid copyWithZone:zone];
        copy.sex = self.sex;
        copy.province = [self.province copyWithZone:zone];
    }
    
    return copy;
}


@end
