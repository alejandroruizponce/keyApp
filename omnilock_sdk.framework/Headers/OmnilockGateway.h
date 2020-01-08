//  Created by Maubic on 2018/07/23.
//  Copyright © 2018 Omnitec. All rights reserved.


#import <Foundation/Foundation.h>

@interface OmnilockGateway : NSObject
/**
   * Block of progress connection
   *
   * @param process progress
   */
typedef void(^TTSmartLinkProcessBlock)(NSInteger process);


/**
   * Block after successful setup
   *
   * @param ip
   * @param mac
   */
typedef void(^TTSmartLinkSuccessBlock)(NSString *ip,NSString *mac);

/**
   * Set failed information
   *
   * The connection timed out, please confirm if the gateway is in an addable state.
   */
typedef void(^TTSmartLinkFailBlock)();


/**
   * Get the currently connected wireless network name SSID. If it returns nil, the current mobile phone is not connected to the wireless network.
   */
+ (NSString *)getSSID;

/**
   * Start configuration (method 1)
   *
   * @param SSID Wireless Network Name
   * @param wifiPwd wireless password (can't have Chinese)
   * @param uid user id
   * @param userPwd user password (plain text)
   */
+(void)startWithSSID:(NSString*)SSID wifiPwd:(NSString*)wifiPwd uid:(int)uid userPwd:(NSString*)userPwd  processblock:(TTSmartLinkProcessBlock)pblock successBlock:(TTSmartLinkSuccessBlock)sblock failBlock:(TTSmartLinkFailBlock)fblock;

/**
    Start configuration (method 2, function is the same as method 1)
 
   @param infoDic key:SSID type:NSString
                    Key:wifiPwd type:NSString
                    Key:uid type:NSNumber
                    Key:userPwd type:NSString
   @param pblock progress callback
   @param sblock successful callback
   @param fblock failed callback
   */
+(void)startWithInfoDic:(NSDictionary*)infoDic processblock:(TTSmartLinkProcessBlock)pblock successBlock:(TTSmartLinkSuccessBlock)sblock failBlock:(TTSmartLinkFailBlock)fblock;

@end
