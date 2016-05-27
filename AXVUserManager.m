//
//  AXVServiceManager.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/6/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVUserManager.h"
#import "STKeychain.h"

static NSString *const kAXVServiceManagerUserNameKey = @"kAXVServiceManagerUserNameKey";
static NSString *const kAXVServiceManagerPasswordKey = @"kAXVServiceManagerPasswordKey";
static NSString *const kAXVServiceManagerServiceId = @"com.axionvpn.AxionVPN";
@implementation AXVUserManager

+(instancetype)sharedInstance
{
    static AXVUserManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        sharedInstance = [[AXVUserManager alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        NSString *userName = [STKeychain getPasswordForUsername:kAXVServiceManagerUserNameKey
                                                 andServiceName:kAXVServiceManagerServiceId
                                                          error:nil];
        NSString *password = [STKeychain getPasswordForUsername:kAXVServiceManagerPasswordKey
                                                 andServiceName:kAXVServiceManagerServiceId
                                                          error:nil];
        
        if (userName != nil &&
            password != nil)
        {
            _currentUser = [AXVUser userWithUserName:userName andPassword:password];
        }
    }
    
    return self;
}

-(void)handleUserLoggedInAsUser:(AXVUser *)user
{
    _currentUser = user;
    
    [STKeychain storeUsername:kAXVServiceManagerUserNameKey
                  andPassword:user.userName
               forServiceName:kAXVServiceManagerServiceId
               updateExisting:YES
                        error:nil];
    [STKeychain storeUsername:kAXVServiceManagerPasswordKey
                  andPassword:user.password
               forServiceName:kAXVServiceManagerServiceId
               updateExisting:YES
                        error:nil];
}

-(void)logOut
{
    for (NSString *key in @[kAXVServiceManagerUserNameKey,kAXVServiceManagerPasswordKey])
    {
        [STKeychain deleteItemForUsername:key
                           andServiceName:kAXVServiceManagerServiceId
                                    error:nil];
    }
}

@end
