//
//  AXVGeositeManager.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 6/3/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVGeositeManager.h"
#import "AXVDataSource.h"

@interface AXVGeositeManager ()
{
    AXVDataSource *dataSource;
}

@end

@implementation AXVGeositeManager

+(instancetype)sharedInstance
{
    static AXVGeositeManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        sharedInstance = [[AXVGeositeManager alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        dataSource = [[AXVDataSource alloc] init];
    }
    
    return self;
}

-(void)loadGeosites
{
    [dataSource getGeositesWithCompletionBlock:^(NSError *error, NSArray<AXVGeosite *> *givenGeositesArray)
    {
        if (error != nil)
        {
            NSLog(@"Error: %@",error);
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kAXVGeositeManagerLoadedGeositesNotificationName
                                                                object:givenGeositesArray];
        }
    }];
}

@end
