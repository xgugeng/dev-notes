//
//  BIDPlace.h
//  WhereAmI
//
//  Created by JN on 2014-1-13.
//  Copyright (c) 2014 apress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BIDPlace : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end
