//
//  OnFoundDeviceModel.h
//  RentAndPass_Demo
//
//  Created by sergio on 23/12/18.
//  Copyright © 2018 Maubic. All rights reserved.
//

#ifndef OnFoundDeviceModel_h
#define OnFoundDeviceModel_h

#import <CoreBluetooth/CoreBluetooth.h>

@interface OnFoundDeviceModel : NSObject

@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic,strong) NSNumber * rssi ;
@property (nonatomic,strong) NSString *lockName;
@property (nonatomic,strong) NSString *mac;
@property (nonatomic,strong) NSDictionary * advertisementData;
@property (nonatomic,assign) BOOL isContainAdmin;
@property (nonatomic,assign) int protocolType;
@property (nonatomic,assign) int protocolVersion;
@property (nonatomic,assign) BOOL  isAllowUnlock;
@property (nonatomic,assign) int oneMeterRSSI;

- (instancetype)initOnFoundDeviceModelWithDic:(NSDictionary*)dic;
@end

#endif /* OnFoundDeviceModel_h */
