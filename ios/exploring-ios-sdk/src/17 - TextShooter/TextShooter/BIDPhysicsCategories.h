//
//  BIDPhysicsCategories.h
//  TextShooter
//
//  Created by JN on 2014-1-17.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#ifndef TextShooter_BIDPhysicsCategories_h
#define TextShooter_BIDPhysicsCategories_h

typedef NS_OPTIONS(uint32_t, BIDPhysicsCategory) {
    PlayerCategory        =  1 << 1,
    EnemyCategory         =  1 << 2,
    PlayerMissileCategory =  1 << 3
};

#endif
