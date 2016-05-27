//
//  AXVGeosite.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/6/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVGeosite.h"

static NSString *const kAXVGeositeIdKey = @"id";
static NSString *const kAXVGeositeGeoAreaKey = @"geo_area";

@implementation AXVGeosite

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self != nil)
    {
        self.geositeId = [dictionary objectForKey:kAXVGeositeIdKey];
        self.geoArea = [dictionary objectForKey:kAXVGeositeGeoAreaKey];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@",self.geositeId,self.geoArea];
}

@end
