//
//  Created by Maubic on 2018/07/23.
//  Copyright © 2018 Omnitec. All rights reserved.
//
//

#import <Foundation/Foundation.h>

/** error code
    *
    */
typedef NS_ENUM(NSInteger, OmnilockError)
{
    OmnilockErrorHadReseted = 0, /** The lock may have been reset */
    OmnilockErrorDataCRCError = 0x01, /** CRC check error */
    OmnilockErrorNoPermisston = 0x02, /** Identity verification failed, no operation rights */
    OmnilockErrorIsWrongPS = 0x03, /** The administrator password is incorrect */
    OmnilockErrorNoMemory = 0x04, /** Insufficient storage space, exceeding the maximum number of saved users */
    OmnilockErrorInSettingMode = 0x05, /** is in setup mode (opening must be in non-set mode) */
    OmnilockErrorNoAdmin = 0x06, /** No administrator exists */
    OmnilockErrorIsNotSettingMode = 0x07, /** is in non-set mode (adding administrator must be in setup mode) */
    OmnilockErrorIsWrongDynamicPS = 0x08, /** Dynamic password error (consist number is wrong with random number) */
    OmnilockErrorIsNoPower = 0x0a, /** The battery is dead, unable to open the door */
    OmnilockErrorResetKeyboardPs = 0x0b, /** Failed to set 900 password */
    OmnilockErrorUpdateKeyboardIndex = 0x0c, /** Error updating keyboard password sequence */
    OmnilockErrorIsInvalidFlag = 0x0d, /** invalid flag */
    OmnilockErrorEkeyOutOfDate = 0x0e, /** ekey expired */
    OmnilockErrorPasswordLengthInvalid = 0x0f, /** Invalid password length */
    OmnilockErrorSuperPasswordIsSameWithDeletePassword = 0x10, /** The administrator password is equal to the delete password */
    OmnilockErrorEkeyNotToDate = 0x11, /** has not expired */
    OmnilockErrorAesKey = 0x12, /** Not logged in No operating privileges */
    OmnilockErrorFail = 0x13, /** operation failed */
    OmnilockErrorPsswordExist = 0x14, /** The added password already exists */
    OmnilockErrorPasswordNotExist = 0x15, /** The deleted or modified password does not exist */
    OmnilockErrorNoFree_Memory = 0x16, /** Insufficient storage space (such as when adding a password, exceeds the storage capacity)*/
    OmnilockErrorInvalidParaLength = 0x17, /** The parameter length is invalid */
    OmnilockErrorCardNotExist = 0x18, /** IC card does not exist */
    OmnilockErrorFingerprintDuplication = 0x19, /** Repeat fingerprint */
    OmnilockErrorFingerprintNotExist = 0x1A, /** Fingerprint does not exist */
    OmnilockErrorInvalidClientPara = 0x1D, /** Invalid special string */
    OmnilockErrorNotSupportModifyPwd = 0x60 /** does not support changing passwords */
};

/*!
 *  @enum OmnilockManagerState
 *
 *  @discussion Represents the current state of a Manager.
 *
 *  @constant ManagerStateUnknown       State unknown, update imminent.
 *  @constant ManagerStateResetting     The connection with the system service was momentarily lost, update imminent.
 *  @constant ManagerStateUnsupported   The platform doesn't support the Bluetooth Low Energy Central/Client role.
 *  @constant ManagerStateUnauthorized  The application is not authorized to use the Bluetooth Low Energy role.
 *  @constant ManagerStatePoweredOff    Bluetooth is currently powered off.
 *  @constant ManagerStatePoweredOn     Bluetooth is currently powered on and available to use.
 *
 */
typedef NS_ENUM(NSInteger, OmnilockManagerState) {
    OmnilockManagerStateUnknown = 0,
    OmnilockManagerStateResetting,
    OmnilockManagerStateUnsupported,
    OmnilockManagerStateUnauthorized,
    OmnilockManagerStatePoweredOff,
    OmnilockManagerStatePoweredOn,
} ;



typedef NS_ENUM(int, DoorSceneType)
{
    CommonDoorLockSceneType = 1,
    AdvancedDoorLockSceneType = 2,
    RYDoorLock = 3,
    GateLockSceneType = 4,
    SafeLockSceneType = 5,
    BicycleLockSceneType = 6,
    ParkSceneType = 7
};

/**
* Keyboard password type
*/
typedef NS_ENUM(NSInteger, KeyboardPsType)
{
             KeyboardPsTypeOnce = 1, /** Single password */
             KeyboardPsTypePermanent = 2, /** permanent password */
             KeyboardPsTypePeriod = 3, /** time limit password */
             KeyboardPsTypeCycle = 4 /** Cycle Password **/
    
};

/** Password IC card and other types of operation
 *
 */
typedef NS_ENUM(NSInteger,OperationType)
{
    OperationTypeClear = 1, /** Clear */
    OperationTypeAdd = 2, /** Add */
    OperationTypeDelete = 3, /** Delete */
    OperationTypeModify = 4, /** Modify */
    OperationTypeQuery = 5, /** Query */
    OperationTypeRecover = 6 /** Recovery */
    
};

/*!
        * @enum TTDoorSensorState
        *
        * @discussion magnetic state
        *
        * @constant TTDoorSensorStateOff No door magnetism detected
        * @constant TTDoorSensorStateOn detected door magnetism
        *
*/
typedef NS_ENUM(NSInteger,DoorSensorState)
{
    DoorSensorStateOff = 0,
    DoorSensorStateOn = 1,
};

/** Add the status type returned by the IC card
*
*/
typedef NS_ENUM(NSInteger, AddICState)
{
    AddICStateHadAdd = 1, /** Identified the IC card and successfully added */
    AddICStateCanAdd = 2, /** Successfully started adding IC card mode */
    
};

/** Add the status type returned by the fingerprint
        *
        */
typedef NS_ENUM(NSInteger,AddFingerprintState)
{
    AddFingerprintCollectSuccess = 1, /** Add fingerprint successfully Contains the fingerprint number, other fields do not have this field. */
    AddFingerprintCanCollect = 2, /** Successfully launch the add fingerprint mode, then the app can prompt "please press your finger" */
    AddFingerprintCanCollectAgain = 3, /** The first time the fingerprint is successfully collected, the second acquisition is started. At this time, the App can prompt “Please press the finger again” */
    };

/** Read the type of device information
        *
*/
typedef NS_ENUM(NSInteger,DeviceInfoType) {
    DeviceInfoTypeOfProductionModel = 1, /** 1- Product Model */
    DeviceInfoTypeOfHardwareVersion = 2, /** 2- Hardware version number */
    DeviceInfoTypeOfFirmwareVersion = 3, /** 3- Firmware version number */
    DeviceInfoTypeOfProductionDate = 4, /** 4 Production date */
    DeviceInfoTypeOfProductionMac = 5, /** 5- Bluetooth address */
    DeviceInfoTypeOfProductionClock = 6 /** 6- Clock */
    
};
    
//1 is search 2 is added
typedef NS_ENUM(NSInteger, AdvertisementDataType)
{
    AdvertisementDataTypeSearch = 1,
    AdvertisementDataTypeAdd,
};

/*!
 * @enum OMLockSwitchState
 *
 * @discussion lock switch status
 *
 * @constant LockStateLock is locked
 * @constant LockStateUnlock unlocked
 * @constant LockStateUnknown Status unknown
 * @constant LockStateUnlockHasCar unlocked, with car
 */
 
 typedef NS_ENUM(NSInteger,OMLockSwitchState)
 {
 OMLockSwitchStateLock = 0,
 OMLockSwitchStateUnlock = 1,
 OMLockSwitchStateUnknown = 2,
 OMLockSwitchStateUnlockHasCar = 3,
 };
 




@interface OMUtils : NSObject

#define DEBUG_UTILS YES
#define DateFormateStringDefault @"yyyy-MM-dd HH:mm:ss"
#define RSSI_SETTING_1m -85 //Corresponding unlocking distance 1m
#define RSSI_SETTING_2m -150 //Corresponding unlocking distance 2m
#define RSSI_SETTING_3m -180 //Corresponding unlocking distance 3m
#define RSSI_SETTING_4m -210 //Corresponding unlocking distance 4m
#define RSSI_SETTING_5m -240 //Corresponding unlocking distance 5m

#define DISTANCE_DEFAULT_FOR_SAVE 2.5f // The default unlock distance

#define RSSI_SETTING_MAX -65 //Corresponding to the nearest distance 0.5m
#define RSSI_SETTING_MIN -140

#define RSSI_SETTING_MIDDLE_0 -85
#define RSSI_SETTING_MIDDLE_1 -100

#pragma mark --- Time conversion
/** Converts the NSDate type to a string and converts the time in the lock timebase according to timezoneRawOffset */
+(NSString*)formateDate:(NSDate*)date format:(NSString*)format timezoneRawOffset:(long)timezoneRawOffset;

+(NSDate*)formateDateFromStringToDate:(NSString*)dateStr format:(NSString*)format timezoneRawOffset:(long)timezoneRawOffset;

/** Get the current year. Year format is yyyy*/
+ (NSString *)getCurrentYear;

#pragma mark --- Data type conversion
+(int)intFromHexBytes:(Byte*)bytes length:(int)dataLen;
+(long long)longFromHexBytes:(Byte*)bytes length:(int)dataLen;
+(NSString*)stringFormBytes:(Byte*)bytes length:(int)dataLen;

+(NSData*)DataFromHexStr:(NSString *)hexString;

+(BOOL)isString:(NSString*)source contain:(NSString*)subStr;

+(long) getLongForBytes:(Byte*)packet;

+(void) printByteByByte:(Byte *)packet withLength:(int)length;

+(Byte)generateRandomByte;

+(void) arrayCopyWithSrc:(Byte*)src srcPos:(int)srcPos dst:(Byte*)dst dstPos:(NSUInteger)dstPos length:(NSUInteger)length;

+(void)getMacBytes:(NSString*)macStr withByte:(Byte*)macBytes;

+(void) generateDynamicPassword:(Byte*)bytes length:(int) length;

+(NSString *) generateDynamicPassword:(int) length;

+(NSData *)EncodeScienerPSBytes:(Byte *)sourceBytes length:(int)length;

+(NSData *)EncodeScienerPS:(NSString *)password;
+(NSData *)DecodeScienerPSToData:(NSData *)data;
+(NSString *)DecodeScienerPS:(NSData *)data;

+(int)RandomNumber0To9_length:(int)length;

+(int)RandomInt0To9;
+ (NSString *)getRandom7Length;
+(NSString *) md5: (NSString *) inPutText;
+(NSString*)EncodeSharedKeyValue:(NSString*)edate;
+(NSString*)DecodeSharedKeyValue:(NSString*)edateStr;

+ (int)convertToByte:(NSString*)str;

@end
