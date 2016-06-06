//
//  AXVGeositeManager.h
//  AxionVPNiOS
//
//  Created by AxionVPN on 6/3/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kAXVGeositeManagerLoadedGeositesNotificationName = @"kAXVGeositeManagerLoadedGeositesNotificationName";

@interface AXVGeositeManager : NSObject

+(instancetype)sharedInstance;
-(void)loadGeosites;

@end
