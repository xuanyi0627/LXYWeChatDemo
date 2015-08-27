//
//  WX_AccessTokenModel.h
//  LXYWeChatDemo
//
//  Created by Echo on 8/27/15.
//  Copyright (c) 2015 Echo. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WX_AccessTokenModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, assign) int64_t expiresIn;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *openid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
