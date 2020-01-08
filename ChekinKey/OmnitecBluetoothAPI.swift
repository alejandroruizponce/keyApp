//
//  OmnitecBluetoothAPI.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 07/03/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import Foundation

struct OmnitecBluetoothAPI {
    
    static var omni: RPDemoHelper?
    
    static func findDevices() {
        self.omni = RPDemoHelper.shareInstance()
    }
    
    static func openLock() {
        self.omni?.omObject.startBLEScan(true)
    }
    
    
        
}
