//
//  LockModel.h
//  RentAndPass_Demo
//
//  Created by sergio on 23/12/18.
//  Copyright © 2018 Maubic. All rights reserved.
//

#ifndef LockModel_h
#define LockModel_h

#import <Foundation/Foundation.h>

@interface LockVersion : NSObject

@property (nonatomic, assign) NSInteger protocolType;

@property (nonatomic, assign) NSInteger protocolVersion;

@property (nonatomic, assign) NSInteger scene;

@property (nonatomic, assign) NSInteger groupId;

@property (nonatomic, assign) NSInteger orgId;



@end



#endif /* LockModel_h */
