
//
//  Created by Maubic on 2018/07/23.
//  Copyright © 2018 Omnitec. All rights reserved.


#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>
#import <OMTool/OMTool.h>

@class OMNILock;

@protocol OMNILockDelegate <NSObject>   //define delegate protocol
- (void) onActivateBLE: (OMNILock *) sender;  //define delegate method to be implemented within another class

/**
  * When the state of Bluetooth changes, the central manager whose state has changed.
  */
- (void)OmnilockManagerDidUpdateState:(OmnilockManagerState)state;

/**
  * Error callback
  *
  * @param error error code
  * @param command wrong command value
  * @param errorMsg error message
  */
-(void)OmnilockError:(OmnilockError)error command:(int)command errorMsg:(NSString*)errorMsg;

/**
  * Bluetooth search to device callback
  * infoDic returns the parameter to the dictionary. The meaning of the corresponding key and its value
  * peripherally searched for Bluetooth objects
  * rssi signal value
  * lockName lock name
  * mac address of lockMac lock
  * IsContainAdmin lock exists for administrator (ie, whether it is in setup mode) Example: YES exists (non-set mode) NO does not exist (set mode)
  * isAllowUnlock A signal value broadcast in the third-generation lock YES for someone touching the lock, the second-generation lock is always YES, the parking lock is always NO
  * OneMeterRSSI A signal value broadcast in the third-generation lock. This value is a fixed value of the rssi second-generation lock about one meter away from the lock.
  * protocolType protocol category Example: 5 is the door lock 10 is the parking lock 0x3412 is the bracelet
  * protocolVersion protocol version returned value 1 is LOCK 4 is the second generation lock 3 is the third generation lock
  * scene type: DoorSceneType application scenario
  * lockSwitchState Type: OMLockSwitchState The lock state of the parking lock (scene == 7). The value returned by the lock that does not support this function is OMLockSwitchStateUnknown.
  * doorSensorState type: OMDoorSensorState gate state
  * electricQuantity type: int lock power (lock to get no power, electricQuantity == -1)
  */
-(void)onFoundPeripheral:(NSDictionary*)infoDic;

/**
  * Callback has been connected to Bluetooth
  *
  * @param peripheral searched for Bluetooth objects
  * @param lockName lock name
  */

-(void)onBTDeviceConnected:(CBPeripheral *)peripheral lockName:(NSString*)lockName;

/**
  * Disconnect from Bluetooth
  *
  * @param peripheral searched for Bluetooth objects
  */
-(void)onBTDeviceDisconnected:(CBPeripheral*)peripheral;

/**
  * Get the version number of the lock successfully
  * @param versionStr is connected by a dot (.) in the middle of (protocolType.protocolVersion.scene.groupId.orgId)
  */
-(void)onGetProtocolVersion:(NSString*)versionStr;

/**
  * Add administrator success to return parameters in dictionary form
  * adminPS administrator password, the administrator checks the administrator's identity when opening the door
  * lockKey number of appointments to open the door
  * aesKey Aes encryption and decryption key
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * lockMac mac address unique identifier
  * timestamp timestamp
  * pwdInfo encrypted password data
  * electricQuantity If it is -1, it means that no power is obtained.
  * adminPassword administrator open password
  * deletePassword administrator delete password
  * Characteristic (LongLong) lock eigenvalues. Use the class OMSpecialValueUtil to determine what features are supported
  * unlockFlag flag bit is 0 when the addition is successful. Note: If this parameter is not returned here, write 0.
  * DeviceInfoType Type: NSDictionary Read device information 1 2 3 4 5 6 Reference enumeration DeviceInfoType Include 1-Product model 2-Hardware version number 3-Firmware version number 4-Production date 5-Bluetooth address 6-Clock
  * timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized, in milliseconds (milliseconds)
  */
-(void)onAddAdminInfoDic:(NSDictionary*)addAdminInfoDic;

/**
  * Calibration time is successful
  */
-(void)onSetLockTime;
/**
  * Unlocked successfully The parameter lockTime is the time in the lock (only three generations of locks have this time, others are 0)
  */
-(void)onUnlock:(NSTimeInterval)lockTime electricQuantity:(int)electricQuantity;

/**
  * On (closed, upper) lock success Parameter lockTime is the time in the lock (only three generations of locks have this time, others are 0)
  */
- (void)onLocking:(NSTimeInterval)lockTime electricQuantity:(int)electricQuantity;

/**
  * Set the administrator to open the password successfully
  */
-(void)onSetAdminKeyboardPasscode;
/**
  * Set the administrator to delete the password successfully.
  */
-(void)onSetAdminDeleteKeyboardPasscode;
/**
  * Reset keyboard password successfully
  */
-(void)onResetKeyboardPasscode_timestamp:(NSString *)timestamp pwdInfo:(NSString *)pwdInfo;
/**
  * Reset electronic key successfully
  */
-(void)onResetKey;

/**
  * Get the power of the lock successfully
  * @param electricQuantity
  */
-(void)onGetBatteryStatus:(int)electricQuantity;

/**
  * Restore factory settings (only three generation locks are available)
  */
-(void)onResetDevice;
/**
  * Read the unlock record or IC card record or fingerprint record or open the door password. Successful callback (only three generation locks are available)
  * LockOpenRecordStr has data to return a string in json format No data returns nil
  */
- (void)onGetOperateLog_DeviceOpenRecordStr:(NSString *)LockOpenRecordStr;
/**
  * Delete a single keyboard password (only three generations of locks have)
  */
- (void)onDeleteUserKeyBoardPasscode;
/**
  Modify the keyboard password (only three generations of locks are available)
  */
- (void)onModifyUserKeyBoardPasscode;
/**
  Add a keyboard password (only three generation locks are available)
  */
- (void)onAddUserKeyBoardPassword;
/**
  * Get own values
  The characteristic value of the characteristic lock uses the class OMSpecialValueUtil to determine what functions are supported.
  */
- (void)onGetDeviceCharacteristic:(long long)characteristic;
/**
  * Get lock time (only three generation locks are available)
  */
- (void)onGetLockTime:(NSTimeInterval)lockTime;


/**
  * Low battery alarm (only LOCK lock is available)
  */
- (void)onLowPower;

/**
  Query lockout time
  currentTime current blocking time
  minTime lock minimum lockout time
  maxTime lock maximum lockout time
  */
- (void)onQueryLockingTimeWithCurrentTime:(int)currentTime minTime:(int)minTime maxTime:(int)maxTime;
/**
   Modify the lockout time successfully
  */
- (void)onModifyLockingTime;
/**
   Read device information
   Key reference enumeration in infoDic dictionary OMUtils.h -> DeviceInfoType
  */
- (void)onGetDeviceInfo:(NSDictionary*)infoDic;
/**
   Enter the firmware upgrade status
  */
- (void)onEnterFirmwareUpgradeMode;

/**
  The status on the query screen is displayed successfully.
  
  @param state 0-hidden 1-display
  */
- (void)onQueryScreenStatus:(BOOL)state;

/**
  Modify the status on the screen to display success
  */
- (void)onModifyScreenShowStatus;

@end //end protocol


@interface OMNILock : NSObject


/** SDK Agent*/
@property (nonatomic, weak) id <OMNILockDelegate> delegate;
/** The unique identifier of the user on the server, used to lock the internal storage operation record ie openid */
@property (nonatomic, strong) NSString *uid;

@property (nonatomic,assign) BOOL isShowBleAlert;
/**Center device object*/
@property (nonatomic,strong,readonly) CBCentralManager *manager;
/** currently connected Bluetooth*/
@property (nonatomic,strong, readonly) CBPeripheral *activePeripheral;
/*!
 *  @property state
 *
 *  @discussion The current state of the manager, initially set to <code>OmniLockManagerStateUnknown</code>.
 *                Updates are provided by required delegate method {@link OmniLockLockManagerDidUpdateState:}.
 *
 */
@property(nonatomic, assign, readonly) OmnilockManagerState state;
/*!
 *  @property isScanning
 *
 *  @discussion Whether or not the central is currently scanning.
 *
 */
@property(nonatomic, assign, readonly) BOOL isScanning NS_AVAILABLE(NA, 9_0);


/**Initialization Division Bluetooth Class*/
-(id)initWithDelegate:(id<OMNILockDelegate>)OMNILockDelegate;

/**Get a singleton*/
+ (OMNILock*)sharedInstance;

/**Create a Bluetooth object
  *
  */
-(void)setupBlueTooth;

/**
  Start scanning for nearby Bluetooth specific door locks
  
  @param isScanDuplicates every time the peripheral is seen, which may be many times per second. This can be useful in specific situations. If you only support v3 lock, we recommend this value to be 'NO', otherwise to be 'YES'.
  *
  * @see onFoundPeripheral:
  */
-(void)startBLEScan:(BOOL)isScanDuplicates;
/**
  Start scanning nearby Bluetooth all Bluetooth devices If you need to develop a bracelet, you can use
  
  @param isScanDuplicates every time the peripheral is seen, which may be many times per second. This can be useful in specific situations.Recommend this value to be NO
  *
  * @see onFoundPeripheral:
  */
- (void)startBLEScanNearbyDevices:(BOOL)isScanDuplicates;

/** Stop scanning nearby Bluetooth
  */
-(void)stopBLEScan;

/** Connect Bluetooth Connection attempts never time out .Pending attempts are cancelled automatically upon deallocation of <i>peripheral</i>, and explicitly via {@link disconnect}.
  *
  * @see onBTDeviceConnected:lockName:
  */
-(void)connect:(CBPeripheral *)peripheral;

/** Disconnect Bluetooth
  *
  * @see onBTDeviceDisconnected:
  */
-(void)disconnect:(CBPeripheral *)peripheral;

/**
  Connection Bluetooth connection attempts never time out .Pending attempts are cancelled automatically upon deallocation of <i>peripheral</i>, and explicitly via {@link cancelConnectPeripheralWithMac}.
  @param lockMac lock mac address (old lock does not have mac address to pass lockName lock name)
  *
  * @see onBTDeviceConnected:lockName:
  */
- (void)connectPeripheralWithMac:(NSString *)lockMac;
/**
  Unlink Bluetooth
  @param lockMac lock mac address (old lock does not have mac address to pass lockName lock name)
  *
  * @see onBTDeviceDisconnected:
  */
- (void)cancelConnectPeripheralWithMac:(NSString *)lockMac;

/**
  * Add administrator (also applies to parking lock)
  * param addDic parameter is the meaning of the corresponding key and its value below the dictionary
  * lockMac lock mac
  * protocolType protocol category
  * protocolVersion protocol version
  * adminPassward can not pass the administrator password (the parking lock does not have this function). If nil is passed, the 7-digit password is randomly generated.
  * deletePassward can not pass the empty code (park lock and three-generation lock does not have this function) If you pass nil, randomly generate a 7-digit password
  * Password range: 2nd generation lock 7-9 digits 3rd generation lock 4-9 digits
  *
  * @see onAddAdminInfoDic:
  * @see OmnilockError: command: errorMsg:
  */
-(void)addAdministrator:(NSDictionary *)addDic;

/** Get the lock version
  *
  * @see onGetProtocolVersion:
  * @see OmnilockError: command: errorMsg:
  */
-(void)getProtocolVersion;

/** Administrator unlock (also applies to parking lock, down)
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  * uniqueid record unique identifier for lock internal storage unlock record size can not exceed 4 bytes recommended timestamp (seconds)
  * timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (milliseconds) does not have this value, then -1
  *
  * @see onUnlock:
  * @see OmnilockError: command: errorMsg:
  */
-(void)unlockByAdministrator:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey version:(NSString*)version unlockFlag:(int)flag uniqueid:(NSNumber*)uniqueid timezoneRawOffset:(long) timezoneRawOffset;

/** eKey unlock (also applies to parking lock, down)
  * lockkey appointment number to open the door
  * aesKey open the door
  * startDate start time if it is a permanent key pass [NSDate dateWithTimeIntervalSince1970:0] or 2000-1-1 0:0
  * endDate end time if it is a permanent key pass [NSDate dateWithTimeIntervalSince1970:0] or 2099-12-31 23:59
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  * uniqueid record unique identifier for lock internal storage unlock record size can not exceed 4 bytes recommended timestamp (seconds)
  * timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (milliseconds) does not have this value, then -1
  *
  * @see onUnlock:
  * @see OmnilockError: command: errorMsg:
  */
-(void)unlockByUser:(NSString*)lockkey aesKey:(NSString*)aesKey startDate:(NSDate*)startDate endDate:(NSDate*)endDate version:(NSString*)version unlockFlag:(int)flag uniqueid:(NSNumber* )uniqueid timezoneRawOffset:(long)timezoneRawOffset;

/** eKey calibrates the lock clock and unlocks it, consistent with referenceTime
  * lockkey appointment number to open the door
  * aesKey open the door
  * startDate start time if it is a permanent key pass [NSDate dateWithTimeIntervalSince1970:0] or 2000-1-1 0:0
  * endDate end time if it is a permanent key pass [NSDate dateWithTimeIntervalSince1970:0] or 2099-12-31 23:59
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  * referenceTime incoming calibration time
  * uniqueid record unique identifier for lock internal storage unlock record size can not exceed 4 bytes recommended timestamp (seconds)
  * timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (milliseconds) does not have this value, then -1
  *
  * @see onUnlock:
  * @see OmnilockError: command: errorMsg:
  */
-(void)calibrationTimeAndUnlock:(NSString*)lockkey aesKey:(NSString*)aesKey startDate:(NSDate *)sdate endDate:(NSDate *)edate version:(NSString*)version unlockFlag:(int)flag referenceTime:(NSDate * )time uniqueid:(NSNumber*)uniqueid timezoneRawOffset:(long)timezoneRawOffset;

/**
  Off (closed) lock (applicable to door locks that support this function, also applies to parking locks rising)
  @param lockkey convention number
  @param aesKey aesKey
  @param flag tag bit
  @param uniqueid Record unique identifier Used for lock internal storage unlock record Size cannot exceed 4 bytes Suggested timestamp (seconds)
  @param isAdmin YSE is the administrator. Otherwise, it is the normal user. The administrator start and end time can be arbitrarily transmitted.
  @param sdate Start time If it is a permanent key pass [NSDate dateWithTimeIntervalSince1970:0] or 2000-1-1 0:0
  @param edate End time If it is a permanent key pass [NSDate dateWithTimeIntervalSince1970:0] or 2099-12-31 23:59
  @param timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (millisecond) does not have this value, then -1
  *
  * @see onLocking:
  * @see OmnilockError: command: errorMsg:
  */
- (void)lockingWithLockKey:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)flag uniqueid:(NSNumber*)uniqueid isAdmin:(BOOL)isAdmin startDate:(NSDate *)sdate endDate:(NSDate *)edate timezoneRawOffset:(long)timezoneRawOffset;
/** Calibration lock clock (park lock is not supported)
  * lockkey appointment number to open the door
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  * referenceTime incoming calibration time
  * timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (milliseconds) does not have this value, then -1
  *
  * @see onSetLockTime
  * @see OmnilockError: command: errorMsg:
  */
-(void)setLockTimeWithLockKey:(NSString*)lockkey aesKey:(NSString*)aesKey version:(NSString*)version unlockFlag:(int)flag referenceTime:(NSDate *)time timezoneRawOffset:(long)timezoneRawOffset;

/** Set lock administrator keyboard password
  * keyboardPassword The keyboard password to be set Password range: 2nd generation lock 7-9 digits 3rd generation lock 4-9 digits
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  *
  * @see onSetAdminKeyboardPasscode
  * @see OmnilockError: command: errorMsg:
  */
-(void)setAdminKeyBoardPasscode:(NSString*)keyboardPassword adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey version:(NSString*)version unlockFlag:(int)flag;


/** Set the password to clear the lock
  * delKeyboardPassword Delete keyboard password to be set Password range: 2nd generation lock 7-9 digits 3rd generation lock 4-9 digits
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  *
  * @see onSetAdminDeleteKeyboardPasscode
  * @see OmnilockError: command: errorMsg:
  */
-(void)setAdminDeleteKeyBoardPasscode:(NSString*)delKeyboardPassword adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/**
  * Reset the ordinary key
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  *
  * @see onResetKey
  * @see OmnilockError: command: errorMsg:
  */
-(void)resetKeyByAdminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey  version:(NSString*)version unlockFlag:(int)flag;

/** Reset keyboard password
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  * timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (milliseconds) does not have this value, then -1
  *
  * @see onResetKeyboardPasscode_timestamp:pwdInfo:
  * @see OmnilockError: command: errorMsg:
  */
-(void)resetKeyboardPasscodeByAdminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey version:(NSString*)version unlockFlag:(int)flag;

/** Get the lock power (only three generation locks are available)
  *
  * @see onGetBatteryStatus:
  * @see OmnilockError: command: errorMsg:
  */
-(void)getBatteryStatus:(NSString*)lockkey aesKey:(NSString*)aesKey;

/** Restore factory settings (ie delete locks, only three generations of lock administrators have)
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  *
  * @see onResetDevice
  * @see OmnilockError: command: errorMsg:
  */
-(void)resetLock:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey version:(NSString*)version unlockFlag:(int)flag;
/**
  * Delete a single keyboard password (only three generations of lock administrators have)
  * keyboardPs password to delete
  * passwordType (can be arbitrarily transmitted)
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  *
  * @see onDeleteUserKeyBoardPasscode
  * @see OmnilockError: command: errorMsg:
  */
-(void)deleteOneKeyboardPasscode:(NSString *)keyboardPs adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey passwordType:(KeyboardPsType)passwordType version:(NSString*)version unlockFlag:(int) Flag;
/**
  Modify keyboard password
  
  @param newPassword New password Password range: Three generation lock 4-9 digits If you do not need to change the password, pass nil
  @param oldPassword old password
  @param startDate start time If you do not need to modify the time, pass nil
  @param endDate End time If you do not need to modify the time, pass nil
  @param adminPS administrator password Verify the administrator's identity when the administrator opens the door
  @param lockkey
  @param aesKey Open the door
  @param flag Open the door marker
  @param timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (millisecond) does not have this value, then -1
  *
  * @see onModifyUserKeyBoardPasscode
  * @see OmnilockError: command: errorMsg:
  */
- (void)modifyKeyboardPasscode:(NSString *)newPassword oldPassword:(NSString *)oldPassword startDate:(NSDate*)startDate endDate:(NSDate*)endDate adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString *) aesKey unlockFlag: (int) flag timezoneRawOffset: (long) timezoneRawOffset;


/**
  Restore keyboard password
  
  @param passwordType password type
  @param cycleType loop type loop password needs to pass other types of arbitrary pass
  @param newPassword new password
  @param oldPassword old password
  @param startDate start time
  @param endDate End time Limited time password requires end time Other types can pass nil
  @param adminPS administrator password
  @param lockkey
  @param aesKey Open the door
  @param flag Open the door marker
  @param timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (millisecond) does not have this value, then -1
  *
  * @see onRecoverUserKeyBoardPasscode
  * @see OmnilockError: command: errorMsg:
  */
- (void)recoverKeyboardPasscode:(KeyboardPsType)passwordType cycleType:(NSInteger)cycleType newPassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword startDate:(NSDate*)startDate endDate:(NSDate*)endDate adminPS:(NSString*) adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)flag timezoneRawOffset:(long)timezoneRawOffset;

/**
  Add a keyboard password
  
  @param keyboardPs Password to be added Password range: Three generation locks 4-9 digits
  @param startDate start time must pass
  @param endDate End time Must pass
  @param adminPS administrator password Verify the administrator's identity when the administrator opens the door
  @param lockkey
  @param aesKey Open the door
  @param flag Open the door marker
  @param timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (millisecond) does not have this value, then -1
  *
  * @see onAddUserKeyBoardPassword
  * @see OmnilockError: command: errorMsg:
  
  */
- (void)addKeyboardPasscode:(NSString *)keyboardPs startDate:(NSDate*)startDate endDate:(NSDate*)endDate adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)flag timezoneRawOffset:(long)timezoneRawOffset;
/**
  * Read unlock record (only three generation locks are available)
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  * timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (milliseconds) does not have this value, then -1
  *
  * @see onGetOperateLog_DeviceOpenRecordStr:
  * @see OmnilockError: command: errorMsg:
  */
- (void)getDeviceLog:(NSString*)aesKey version:(NSString *)version unlockFlag:(int)flag timezoneRawOffset:(long)timezoneRawOffset;
/**
  * Get lock time (only three generation locks are available)
  * aesKey open the door
  * version version number consists of (protocolType.protocolVersion.scene.groupId.orgId) connected by a dot (.) in the middle
  * flag tag bit
  * timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (milliseconds) does not have this value, then -1
  *
  * @see onGetLockTime:
  * @see OmnilockError: command: errorMsg:
  */
- (void)getDeviceTime:(NSString*)aesKey version:(NSString*)version unlockFlag:(int)flag timezoneRawOffset:(long)timezoneRawOffset;
/**
  * Get the lock feature value (only three generation locks are available)
  * lockkey appointment number to open the door
  * aesKey open the door
  *
  * @see onGetDeviceCharacteristic:
  * @see OmnilockError: command: errorMsg:
  */
- (void)getDeviceDetails:(NSString*)lockkey aesKey:(NSString*)aesKey;

/**
  * Set the lockout time
  * OperationType only queries and modifications
  * time is the set lock time. Modify: pass 0 is not blocked. Query: can pass any value.
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * unlockFlag flag bit
  *
  * @see onQueryLockingTimeWithCurrentTime: minTime: maxTime:
  * @see onModifyLockingTime
  * @see OmnilockError: command: errorMsg:
  */
- (void)setLockoutTime:(OperationType)type time:(int)time adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)unlockFlag;
/**
  * Read device information including 1-product model number 2-hardware version number 3-firmware version number 4-production date 5- Bluetooth address 6-clock
  * lockkey appointment number to open the door
  * aesKey open the door
  *
  * @see onGetDeviceInfo:
  * @see OmnilockError: command: errorMsg:
  */
- (void)getDeviceInfo:(NSString*)lockkey aesKey:(NSString*)aesKey;
/**
  * Enter firmware upgrade status
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * unlockFlag open flag
  *
  * @see onEnterFirmwareUpgradeMode
  * @see OmnilockError: command: errorMsg:
  */
- (void)upgradeFirmware_adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)unlockFlag;

/** Query lock switch status
  * lockkey appointment number to open the door
  * aesKey open the door
  *
  * @see onGetLockSwitchState:
  * @see OmnilockError: command: errorMsg:
  */
- (void)GetDeviceSwitchStatus:(NSString*)aesKey;
/**
  Whether to display the entered password on the screen
  
  @param type Operation Type 1- Query 2- Modify
  @param isShow Whether to display password 0-Hide 1-Display Operation type is useful when modifying
  @param adminPS administrator password
  @param lockkey convention number
  @param aesKey aesKey
  @param unlockFlag flag bit
  *
  * @see onGetLockSwitchState:
  * @see onModifyScreenShowStatus
  * @see OmnilockError: command: errorMsg:
  */
- (void)operateScreen:(int)type isShow:(BOOL)isShow adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)unlockFlag;
/**
  * Read the unlock password list (only three generations of administrators can read the unlock password) The successful callback is onGetOperateLog_DeviceOpenRecordStr
  * adminPS administrator password
  * aesKey open the door
  * timezoneRawOffset The difference between the time zone and the UTC time zone when the lock is initialized. The unit milliseconds (milliseconds) does not have this value, then -1
  *
  * @see onGetOperateLog_DeviceOpenRecordStr:
  * @see OmnilockError: command: errorMsg:
  */
- (void)getKeyboardPasscodeList:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)unlockFlag timezoneRawOffset:(long)timezoneRawOffset;

/**
  Read new password scheme parameters (contract number, number of maps, date of deletion)
  *
  * @see onGetPasscodeData_timestamp:pwdInfo:
  */
- (void)getPasscodeData:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)unlockFlag timezoneRawOffset:(long)timezoneRawOffset;
/**
  * Door magnetic locking operation
  * OperationType only queries and modifications
  * isOn is to set the door magnetic lock switch Query: can pass any value Modify: pass YES is open, NO is off
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * unlockFlag flag bit
  *
  * @see onQueryDoorLockingSensor:
  * @see onModifyDoorLockingSensor
  * @see OmnilockError: command: errorMsg:
  */
- (void)operateDoorSensorLocking:(OperationType)type isOn:(BOOL)isOn adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)unlockFlag;

/** Query the magnetic status of the door
  * lockkey appointment number to open the door
  * aesKey open the door
  *
  * @see onGetDoorSensorStatus:
  * @see OmnilockError: command: errorMsg:
  */
- (void)getDoorSensorStatus:(NSString*)aesKey;
/**
  * Remote unlock switch control
  * OperationType only queries and modifications
  * isOn is to set the remote unlock switch Query: can pass any value Modify: pass YES is open, NO is off
  * adminPS administrator password to verify the identity of the administrator when the administrator opens the door
  * lockkey appointment number to open the door
  * aesKey open the door
  * unlockFlag flag bit
  *
  * @see onOperateRemoteUnlockSwitch_type:stateInfo:
  * @see OmnilockError: command: errorMsg:
  */
- (void)operateRemoteUnlockSwitch_type:(OperationType)type isOn:(BOOL)isOn adminPS:(NSString*)adminPS lockKey:(NSString*)lockkey aesKey:(NSString*)aesKey unlockFlag:(int)unlockFlag;


/**
  * Get the lock power, call this interface after calling the unlock interface successfully ((deprecated("SDK2.7.5")))
  */
-(int)getPower;



@end




