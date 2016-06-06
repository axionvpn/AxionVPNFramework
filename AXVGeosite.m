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

#define kAXVGeositeTiranaCoordinates CLLocationCoordinate2DMake(41.327546, 19.818698)
#define kAXVGeositeSydneyCoordinates CLLocationCoordinate2DMake(-33.867487, 151.20699)
#define kAXVGeositeMontrealCoordinates CLLocationCoordinate2DMake(45.501689, -73.567256)
#define kAXVGeositeHelsinkiCoordinates CLLocationCoordinate2DMake(60.169856, 24.938379)
#define kAXVGeositeParisCoordinates CLLocationCoordinate2DMake(48.856614, 2.352222)
#define kAXVGeositeFrankfurtCoordinates CLLocationCoordinate2DMake(50.110922, 8.682127)
#define kAXVGeositeHongKongCoordinates CLLocationCoordinate2DMake(22.396428, 114.109497)
#define kAXVGeositeMilanCoordinates CLLocationCoordinate2DMake(45.465422, 9.185924)
#define kAXVGeositeLuxembourgCoordinates CLLocationCoordinate2DMake(49.611621, 6.131935)
#define kAXVGeositeAmsterdamCoordinates CLLocationCoordinate2DMake(52.370216, 4.895168)
#define kAXVGeositeMoscowCoordinates CLLocationCoordinate2DMake(55.755826, 37.6173)
#define kAXVGeositeSingaporeCoordinates CLLocationCoordinate2DMake(1.352083, 103.819836)
#define kAXVGeositeJohannesburgCoordinates CLLocationCoordinate2DMake(-26.204103, 28.047305)
#define kAXVGeositeStockholmCoordinates CLLocationCoordinate2DMake(59.329323, 18.068581)
#define kAXVGeositeAtlantaCoordinates CLLocationCoordinate2DMake(33.748995, -84.387982)
#define kAXVGeositeDallasCoordinates CLLocationCoordinate2DMake(32.776664, -96.796988)
#define kAXVGeositeLosAngelesCoordinates CLLocationCoordinate2DMake(34.052234, -118.243685)
#define kAXVGeositeNewYorkCoordinates CLLocationCoordinate2DMake(40.712784, -74.005941)

@implementation AXVGeosite

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self != nil)
    {
        self.geositeId = [dictionary objectForKey:kAXVGeositeIdKey];
        self.geoArea = [dictionary objectForKey:kAXVGeositeGeoAreaKey];
        [self setCoordinateLocation];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ ()",self.geositeId,self.geoArea];
}

-(void)setCoordinateLocation
{
    CLLocationCoordinate2D coordinateLocation = CLLocationCoordinate2DMake(0, 0);
    
    if ([self.geoArea containsString:@"Tirana"] == YES)
    {
        self.imagePath = @"tirana.jpeg";
        coordinateLocation = kAXVGeositeTiranaCoordinates;
    }
    else if ([self.geoArea containsString:@"Sydney"] == YES)
    {
        self.imagePath = @"sydney.jpeg";
        coordinateLocation = kAXVGeositeSydneyCoordinates;
    }
    else if ([self.geoArea containsString:@"Montreal"] == YES)
    {
        self.imagePath = @"montreal.jpeg";
        coordinateLocation = kAXVGeositeMontrealCoordinates;
    }
    else if ([self.geoArea containsString:@"Helsinki"] == YES)
    {
        self.imagePath = @"helsinki.jpeg";
        coordinateLocation = kAXVGeositeHelsinkiCoordinates;
    }
    else if ([self.geoArea containsString:@"Paris"] == YES)
    {
        self.imagePath = @"paris.jpeg";
        coordinateLocation = kAXVGeositeParisCoordinates;
    }
    else if ([self.geoArea containsString:@"Frankfurt"] == YES)
    {
        self.imagePath = @"frankfurt.jpeg";
        coordinateLocation = kAXVGeositeFrankfurtCoordinates;
    }
    else if ([self.geoArea containsString:@"Hong Kong"] == YES)
    {
        self.imagePath = @"hongkong.jpeg";
        coordinateLocation = kAXVGeositeHongKongCoordinates;
    }
    else if ([self.geoArea containsString:@"Milan"] == YES)
    {
        self.imagePath = @"milan.jpeg";
        coordinateLocation = kAXVGeositeMilanCoordinates;
    }
    else if ([self.geoArea containsString:@"Luxembourg"] == YES)
    {
        self.imagePath = @"luxembourg.jpeg";
        coordinateLocation = kAXVGeositeLuxembourgCoordinates;
    }
    else if ([self.geoArea containsString:@"Amsterdam"] == YES)
    {
        self.imagePath = @"amsterdam.jpeg";
        coordinateLocation = kAXVGeositeAmsterdamCoordinates;
    }
    else if ([self.geoArea containsString:@"Moscow"] == YES)
    {
        self.imagePath = @"moscow.jpeg";
        coordinateLocation = kAXVGeositeMoscowCoordinates;
    }
    else if ([self.geoArea containsString:@"Singapore"] == YES)
    {
        self.imagePath = @"singapore.jpeg";
        coordinateLocation = kAXVGeositeSingaporeCoordinates;
    }
    else if ([self.geoArea containsString:@"Johannesburg"] == YES)
    {
        self.imagePath = @"johannesburg.jpeg";
        coordinateLocation = kAXVGeositeJohannesburgCoordinates;
    }
    else if ([self.geoArea containsString:@"Stockholm"] == YES)
    {
        self.imagePath = @"stockholm.jpeg";
        coordinateLocation = kAXVGeositeStockholmCoordinates;
    }
    else if ([self.geoArea containsString:@"Atlanta"] == YES)
    {
        self.imagePath = @"atlanta.jpeg";
        coordinateLocation = kAXVGeositeAtlantaCoordinates;
    }
    else if ([self.geoArea containsString:@"Dallas"] == YES)
    {
        self.imagePath = @"dallas.jpeg";
        coordinateLocation = kAXVGeositeDallasCoordinates;
    }
    else if ([self.geoArea containsString:@"Los Angeles"] == YES)
    {
        self.imagePath = @"losangeles.jpeg";
        coordinateLocation = kAXVGeositeLosAngelesCoordinates;
    }
    else if ([self.geoArea containsString:@"New York"] == YES)
    {
        self.imagePath = @"newyork.jpeg";
        coordinateLocation = kAXVGeositeNewYorkCoordinates;
    }
    
    self.coordinateLocation = coordinateLocation;
}

@end
