//
//  AXVUser.h
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/9/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXVUser : NSObject

@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *password;

+(instancetype)userWithUserName:(NSString *)userName andPassword:(NSString *)password;

@end
