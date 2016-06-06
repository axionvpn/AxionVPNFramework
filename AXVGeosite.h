//
//  AXVGeosite.h
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/6/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVObject.h"
#import <MapKit/MapKit.h>

@interface AXVGeosite : AXVObject

@property (nonatomic, retain) NSString *geositeId;
@property (nonatomic, retain) NSString *geoArea;
@property CLLocationCoordinate2D coordinateLocation;
@property NSString *imagePath;

@end
