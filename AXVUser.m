//
//  AXVUser.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/9/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVUser.h"

@implementation AXVUser

+(instancetype)userWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    AXVUser *user = [[AXVUser alloc] init];
    
    user.userName = userName;
    user.password = password;
    
    return user;
}

@end
