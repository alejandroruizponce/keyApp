

#import <Foundation/Foundation.h>
#import <omnilock_sdk/OMNILock.h>
#import "Key.h"

#ifndef RPDemoHelper_h
#define RPDemoHelper_h


#define RPDemoHelperClass [RPDemoHelper shareInstance]
#define OMObjectRPDemoHelper [[RPDemoHelper shareInstance] OMObject]

UIKIT_EXTERN NSString *const OMBLEErrorCodeKey ;
UIKIT_EXTERN NSString *const OMBLECommandKey ;

typedef enum {
    OMBLE_CONNECT_DISABLE,
    OMBLE_CONNECT_NONE_TARGET,
    OMBLE_CONNECT_REFUSED,
    OMBLE_CONNECT_TIMEOUT,
    OMBLE_CONNECT_TURNOFF,
    OMBLE_CONNECT_SUCCESS,
    OMBLE_CONNECTED_INSTANTLY_DISCONNECT,
    OMBLE_RENTER_DATED,
}OMBLE_CONNECT_STATUS;

typedef void(^BLEBlock)(id info,BOOL succeed);
typedef void(^BLEConnectBlock)(CBPeripheral *peripheral,OMBLE_CONNECT_STATUS connectStatus);
typedef void(^BLEDisconnectBlock)(CBPeripheral *peripheral);

@interface RPDemoHelper : NSObject<OMNILockDelegate>

+ (instancetype)shareInstance;
- (void)unlockLock;

@property (strong, nonatomic) OMNILock *OMObject;
@property (strong, nonatomic)  Key * currentKey;
@property (strong, nonatomic)  LockVersion * currentLock;
@property (strong, nonatomic)  NSDictionary *adminD;
@property (strong, nonatomic) NSString* adminPwd;
@property (strong, nonatomic) NSString *lockKey;
@property (strong, nonatomic) NSString *aesKeyStr;
@property (strong, nonatomic) NSString *lockVersion;
@property (strong, nonatomic) NSString *lockFlag;
@property (strong, nonatomic) NSString *lockMac;
@property (strong, nonatomic) NSString *timezone;
@property (strong, nonatomic) NSNumber *lockId;
@property (strong, nonatomic) NSArray * results;
@property (strong, nonatomic)  NSDictionary *json;

@end


#endif /* RPDemoHelper_h */


