//
//  AXVObject.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/6/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVObject.h"

@implementation AXVObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self != nil)
    {
        self.dictionaryRepresentation = dictionary;
    }
    
    return self;
}

@end
