//
//  WX_AccessTokenModel.m
//  LXYWeChatDemo
//
//  Created by Echo on 8/27/15.
//  Copyright (c) 2015 Echo. All rights reserved.
//

#import "WX_AccessTokenModel.h"


NSString *const kWX_AccessTokenModelRefreshToken = @"refresh_token";
NSString *const kWX_AccessTokenModelScope = @"scope";
NSString *const kWX_AccessTokenModelExpiresIn = @"expires_in";
NSString *const kWX_AccessTokenModelAccessToken = @"access_token";
NSString *const kWX_AccessTokenModelOpenid = @"openid";


@interface WX_AccessTokenModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WX_AccessTokenModel

@synthesize refreshToken = _refreshToken;
@synthesize scope = _scope;
@synthesize expiresIn = _expiresIn;
@synthesize accessToken = _accessToken;
@synthesize openid = _openid;


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
            self.refreshToken = [self objectOrNilForKey:kWX_AccessTokenModelRefreshToken fromDictionary:dict];
            self.scope = [self objectOrNilForKey:kWX_AccessTokenModelScope fromDictionary:dict];
            self.expiresIn = [[self objectOrNilForKey:kWX_AccessTokenModelExpiresIn fromDictionary:dict] longLongValue];
            self.accessToken = [self objectOrNilForKey:kWX_AccessTokenModelAccessToken fromDictionary:dict];
            self.openid = [self objectOrNilForKey:kWX_AccessTokenModelOpenid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.refreshToken forKey:kWX_AccessTokenModelRefreshToken];
    [mutableDict setValue:self.scope forKey:kWX_AccessTokenModelScope];
    [mutableDict setValue:[NSNumber numberWithLongLong:self.expiresIn] forKey:kWX_AccessTokenModelExpiresIn];
    [mutableDict setValue:self.accessToken forKey:kWX_AccessTokenModelAccessToken];
    [mutableDict setValue:self.openid forKey:kWX_AccessTokenModelOpenid];

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

    self.refreshToken = [aDecoder decodeObjectForKey:kWX_AccessTokenModelRefreshToken];
    self.scope = [aDecoder decodeObjectForKey:kWX_AccessTokenModelScope];
    self.expiresIn = [aDecoder decodeInt64ForKey:kWX_AccessTokenModelExpiresIn];
    self.accessToken = [aDecoder decodeObjectForKey:kWX_AccessTokenModelAccessToken];
    self.openid = [aDecoder decodeObjectForKey:kWX_AccessTokenModelOpenid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_refreshToken forKey:kWX_AccessTokenModelRefreshToken];
    [aCoder encodeObject:_scope forKey:kWX_AccessTokenModelScope];
    [aCoder encodeInt64:_expiresIn forKey:kWX_AccessTokenModelExpiresIn];
    [aCoder encodeObject:_accessToken forKey:kWX_AccessTokenModelAccessToken];
    [aCoder encodeObject:_openid forKey:kWX_AccessTokenModelOpenid];
}

- (id)copyWithZone:(NSZone *)zone
{
    WX_AccessTokenModel *copy = [[WX_AccessTokenModel alloc] init];
    
    if (copy) {

        copy.refreshToken = [self.refreshToken copyWithZone:zone];
        copy.scope = [self.scope copyWithZone:zone];
        copy.expiresIn = self.expiresIn;
        copy.accessToken = [self.accessToken copyWithZone:zone];
        copy.openid = [self.openid copyWithZone:zone];
    }
    
    return copy;
}


@end
