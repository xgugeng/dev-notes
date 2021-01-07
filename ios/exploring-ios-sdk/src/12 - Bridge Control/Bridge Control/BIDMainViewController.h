//
//  BIDMainViewController.h
//  Bridge Control
//
//  Created by JN on 25/10/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "BIDFlipsideViewController.h"

#define kOfficerKey                    @"officer"
#define kAuthorizationCodeKey          @"authorizationCode"
#define kRankKey                       @"rank"
#define kWarpDriveKey                  @"warp"
#define kWarpFactorKey                 @"warpFactor"
#define kFavoriteTeaKey                @"favoriteTea"
#define kFavoriteCaptainKey            @"favoriteCaptain"
#define kFavoriteGadgetKey             @"favoriteGadget"
#define kFavoriteAlienKey              @"favoriteAlien"

@interface BIDMainViewController : UIViewController <BIDFlipsideViewControllerDelegate>

@end
