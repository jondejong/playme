//
//  PMSoundDelegate.h
//  PlayMe
//
//  Created by Jon DeJong on 2/4/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//

#import "PMSoundDelegate.h"

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

FOUNDATION_EXPORT NSString *const BGM_TITLE;
FOUNDATION_EXPORT NSString *const BGM_STAGE1;
FOUNDATION_EXPORT NSString *const BGM_STAGE2;
FOUNDATION_EXPORT NSString *const BGM_STAGE3;
FOUNDATION_EXPORT NSString *const BGM_BONUS1;
FOUNDATION_EXPORT NSString *const BGM_LOST_LIFE;
FOUNDATION_EXPORT NSString *const BGM_GAME_OVER;
FOUNDATION_EXPORT NSString *const SFX_ZOMBIE1;
FOUNDATION_EXPORT NSString *const SFX_ZOMBIE2;

@interface PMSoundDelegate : NSObject

+ (PMSoundDelegate *)sharedInstance;
- (void)setEnabled:(BOOL)enabled;
- (BOOL)isEnabled;
- (void)playBackgroundMusic:(NSString *)resourceName;
- (void)playBackgroundMusicNoLoop:(NSString *)resourceName;
- (void)pauseBackgroundMuisc;
- (void)playSoundEffect:(NSString *)resourceName :(SKScene *)scene;

@end

