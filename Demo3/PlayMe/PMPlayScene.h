//
//  PMPlayScene.h
//  PlayMe
//
//  Created by Jon DeJong on 2/4/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PMPlayScene : SKScene

@property (nonatomic, copy) void (^gameOverBlock)();

@end

