//
//  AXVObject.h
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/6/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXVObject : NSObject

@property (nonatomic, retain) NSDictionary *dictionaryRepresentation;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
