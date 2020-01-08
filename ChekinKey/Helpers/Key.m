//
//  Key.m
//  RentAndPass_Demo
//
//  Created by sergio on 23/12/18.
//  Copyright © 2018 Maubic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Key.h"


@implementation Key

@dynamic keyId;
@dynamic lockId;
@dynamic userType;
@dynamic keyStatus;
@dynamic lockName;
@dynamic lockAlias;
@dynamic lockKey;
@dynamic lockMac;
@dynamic lockFlagPos;
@dynamic electricQuantity;
@dynamic aesKeyStr;
@dynamic lockVersion;
@dynamic startDate;
@dynamic endDate;
@dynamic remarks;
@dynamic peripheralUUIDStr;
@dynamic adminPwd;
@dynamic noKeyPwd;
@dynamic deletePwd;
@dynamic username;
@dynamic timezoneRawOffset;

- (BOOL)isAdmin
{
    return [self.userType isEqualToString:@"110301"];
}

@end

@implementation KeyModel

- (BOOL)isAdmin
{
    return [self.userType isEqualToString:@"110301"];
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if ([property.name isEqualToString:@"startDate"]) {
        if ([oldValue isKindOfClass:[NSNumber class]]) {
            return  [NSNumber numberWithInteger:[oldValue integerValue] / 1000];
        }
    }
    if ([property.name isEqualToString:@"endDate"]) {
        if ([oldValue isKindOfClass:[NSNumber class]]) {
            return  [NSNumber numberWithInteger:[oldValue integerValue] / 1000] ;
        }
    }
    return oldValue;
}

@end

@implementation SyncKeyInfo

+ (void)load
{
    [super load];
    [SyncKeyInfo mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"keyList" : @"KeyModel"
                 };
    }];
    
}

@end

@implementation KeyboardPwdVersion



@end
