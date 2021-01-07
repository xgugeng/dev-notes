//
//  BIDFavoritesList.h
//  Fonts
//
//  Created by JN on 2014-2-3.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIDFavoritesList : NSObject

+ (instancetype)sharedFavoritesList;

- (NSArray *)favorites;

- (void)addFavorite:(id)item;
- (void)removeFavorite:(id)item;

- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;

@end
