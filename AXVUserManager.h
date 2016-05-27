//
//  AXVServiceManager.h
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/6/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXVUser.h"

@interface AXVUserManager : NSObject

@property (nonatomic, retain, readonly) AXVUser *currentUser;

+(instancetype)sharedInstance;
-(void)handleUserLoggedInAsUser:(AXVUser *)user;
-(void)logOut;

@end
