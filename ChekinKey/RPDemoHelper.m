
#import <Foundation/Foundation.h>


#import "RPDemoHelper.h"
#import "OnFoundDeviceModel.h"
#import "Define.h"

NSString * const OMBLE_SCAN = @"ble_scan";
NSString * const OMBLE_CONNECT = @"ble_connect";
NSString * const OMBLE_DISCONNECT = @"ble_disconnect";

BOOL isReachDefaultConnectTimeout;

@interface RPDemoHelper ()

@property (atomic,strong) NSMutableDictionary *bleBlockDict;
@property (atomic,strong) NSNumber *lockUniqueid;
@property (atomic,assign) BOOL isSendCommandByCRCError;

@property (atomic,assign) NSDictionary *firstObjectDict;
@property (atomic,assign) NSString *myValue;

@end

@implementation RPDemoHelper
static  RPDemoHelper *instace;


+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[self alloc]initRPDemoHelper];
        
        
    });
    return instace;
}

#pragma mark -----
- (instancetype)initRPDemoHelper{
    
    self.OMObject =  [[OMNILock alloc]initWithDelegate:self];
    self.OMObject.isShowBleAlert = YES;
    [self.OMObject setupBlueTooth];
    
    _bleBlockDict = [NSMutableDictionary dictionary];
    
    NSLog(@"Hacemos la llamada a la API con token y clientID");
    NSString *path = @"http://api.rentandpass.com/api/key/refresh?clientId=JtCxBdqNpVOSR-aofFiQ5DgZrHjyMb4m&token=f99afb54bf491155c1bb22c2e204e4ae";
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    _json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    _results = [_json objectForKey:@"keyList"];
    
    _adminPwd = [_results [0] objectForKey:@"adminPwd"];
    _lockKey = [_results [0] objectForKey:@"lockKey"];
    _aesKeyStr = [_results [0] objectForKey:@"aesKeyStr"];
    NSDictionary * lockV = [_results [0] objectForKey:@"lockVersion"];
    NSString *protocolType = [lockV  objectForKey:@"protocolType"];
    NSString *protocolVersion = [lockV  objectForKey:@"protocolVersion"];
    NSString *scene = [lockV  objectForKey:@"scene"];
    NSString *groupId = [lockV  objectForKey:@"groupId"];
    NSString *orgId = [lockV  objectForKey:@"orgId"];
    _lockVersion = [NSString stringWithFormat:@"%@.%@", protocolType, protocolVersion, scene, groupId, orgId];
    _lockFlag = [_results [0] objectForKey:@"lockFlagPos"];
    _timezone = [_results [0] objectForKey:@"timezoneRawOffset"];
    _lockId = [_results [0] objectForKey:@"lockId"];
    _lockMac = [_results [0] objectForKey:@"lockMac"];

    return self;
    
}
- (void)OmnilockManagerDidUpdateState:(OmnilockManagerState)state{
    if (state == OmnilockManagerStatePoweredOn) {
        [_OMObject startBLEScan:YES];
    }else if (state == OmnilockManagerStatePoweredOff){
        [_OMObject stopBLEScan];
    }else if (state == OmnilockManagerStateUnsupported){
        dispatch_sync(dispatch_get_main_queue(), ^(void){
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Your device does not support ble4.0, unable to use our app." message:nil delegate:self cancelButtonTitle:LS(@"words_sure_ok") otherButtonTitles: nil];
            
            [alert show];
            
        });
    }
}

#pragma mark OMNILockDelegate
-(void)onFoundPeripheral:(NSDictionary*)infoDic{
    
    OnFoundDeviceModel *onFoundModel = [[OnFoundDeviceModel alloc]initOnFoundDeviceModelWithDic:infoDic];
    
    if (onFoundModel.lockName.length == 0) {
        return;
    }
    
    NSLog(@"MAUBIC DEBUG: RPDemoHelper.onFoundPeripheral Device MAC: %@", onFoundModel.mac);
    
    
    
    

    [_OMObject connectPeripheralWithMac: onFoundModel.mac];
    
}

-(void)onBTDeviceConnected:(CBPeripheral *)peripheral lockName:(NSString*)lockName {
    
    NSLog(@"Conexion con cerradura EXITOSA");
    
    
    
    
    [_OMObject unlockByAdministrator: _adminPwd lockKey: _lockKey aesKey:_aesKeyStr version:_lockVersion unlockFlag: [_lockFlag intValue]  uniqueid: _lockId  timezoneRawOffset: [_timezone longLongValue]];

    [_OMObject stopBLEScan];
    
    _OMObject.uid = peripheral.identifier.UUIDString;
    

}

-(void) unlockLock {
    
    


    
}

@end
