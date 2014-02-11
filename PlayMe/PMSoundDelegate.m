//
//  PMSoundDelegate.m
//  PlayMe
//
//  Created by Jon DeJong on 2/4/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//


#import "PMSoundDelegate.h"
#import <SpriteKit/SpriteKit.h>
@import AVFoundation;

NSString *const BGM_TITLE = @"hh_title";
NSString *const BGM_STAGE1 = @"hh_stage1";
NSString *const BGM_STAGE2 = @"hh_stage2";
NSString *const BGM_STAGE3 = @"hh_stage3";
NSString *const BGM_BONUS1 = @"hh_bonus1";
NSString *const BGM_LOST_LIFE = @"hh_lost_life";
NSString *const BGM_GAME_OVER = @"hh_game_over";
NSString *const SFX_ZOMBIE1 = @"zombie1";
NSString *const SFX_ZOMBIE2 = @"zombie2";

@interface PMSoundDelegate()
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;
@property (nonatomic) BOOL isSoundEnabled;
@property (nonatomic) NSURL * currentBackgroundMusicURL;
@end

@implementation PMSoundDelegate

@synthesize isSoundEnabled = _isSoundEnabled;

+ (PMSoundDelegate *)sharedInstance
{
    static PMSoundDelegate *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PMSoundDelegate alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(id)init {
    if (self = [super init]) {
        _isSoundEnabled=YES;
    }
    return self;
}

- (void)playBackgroundMusic:(NSString *)resourceName
{
    if([self isEnabled])
    {
        NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:resourceName withExtension:@"caf"];
        
        [self playBackgroundMusicFromURL:backgroundMusicURL :-1];
        
    }
}

- (void)playBackgroundMusicNoLoop:(NSString *)resourceName
{
    if([self isEnabled])
    {
        NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:resourceName withExtension:@"caf"];
        
        [self playBackgroundMusicFromURL:backgroundMusicURL :0];
        
    }
}

- (void)playBackgroundMusicFromURL:(NSURL *)backgroundMusicURL :(int)numLoops
{
    if([self isEnabled])
    {
        if([self.backgroundMusicPlayer isPlaying])
        {
            [self pauseBackgroundMuisc];
        }
        
        NSError *error;
        self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
        self.backgroundMusicPlayer.numberOfLoops = numLoops;
        [self.backgroundMusicPlayer prepareToPlay];
        [self.backgroundMusicPlayer play];
    }
}

- (void)playSoundEffect:(NSString *)resourceName :(SKScene *)scene
{
    [scene runAction:[SKAction playSoundFileNamed:[resourceName stringByAppendingString:@".caf"] waitForCompletion:NO]];
}

- (void)pauseBackgroundMuisc
{
    if([self isEnabled])
    {
        [self.backgroundMusicPlayer pause];
    }
}

- (void)resumeBackgroundMuisc
{
    if([self isEnabled])
    {
        [self.backgroundMusicPlayer play];
    }
}

- (void)setEnabled:(BOOL)enabled
{
    self.isSoundEnabled = enabled;
    if(![self isEnabled])
    {
        if([self.backgroundMusicPlayer isPlaying])
        {
            self.currentBackgroundMusicURL = [self.backgroundMusicPlayer url];
            [self.backgroundMusicPlayer stop];
        }
    }
    else
    {
        if(![self.backgroundMusicPlayer isPlaying])
        {
            [self playBackgroundMusicFromURL:self.currentBackgroundMusicURL :-1];
        }
    }
}

-(BOOL)isEnabled
{
    return self.isSoundEnabled;
}



@end
