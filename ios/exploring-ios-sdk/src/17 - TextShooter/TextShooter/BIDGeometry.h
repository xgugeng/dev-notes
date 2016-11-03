//
//  BIDGeometry.h
//  TextShooter
//
//  Created by JN on 2013-12-16.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#ifndef TextShooter_BIDGeometry_h
#define TextShooter_BIDGeometry_h

// Takes a CGVector and a CGFLoat.
// Returns a new CGFloat where each component of v has been multiplied by m.
static inline CGVector BIDVectorMultiply(CGVector v, CGFloat m) {
    return CGVectorMake(v.dx * m, v.dy * m);
}

// Takes two CGPoints.
// Returns a CGVector representing a direction from p1 to p2.
static inline CGVector BIDVectorBetweenPoints(CGPoint p1, CGPoint p2) {
    return CGVectorMake(p2.x - p1.x, p2.y - p1.y);
}

// Takes a CGVector.
// Returns a CGFloat containing the length of the vector, calculated using
// Pythagoras’ theorem.
static inline CGFloat BIDVectorLength(CGVector v) {
    return sqrtf(powf(v.dx, 2) + powf(v.dy, 2));
}

// Takes two CGPoints. Returns a CGFloat containing the distance between them,
// calculated using Pythagoras’ theorem.
static inline CGFloat BIDPointDistance(CGPoint p1, CGPoint p2) {
    return sqrtf(powf(p2.x - p1.x, 2) + powf(p2.y - p1.y, 2));
}


#endif
