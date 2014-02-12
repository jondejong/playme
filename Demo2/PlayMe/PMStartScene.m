//
//  PMStartScene.m
//  PlayMe
//
//  Created by Jon DeJong on 2/4/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//

#import "PMStartScene.h"
#import "PMPlayScene.h"

@interface PMStartScene ()
@property BOOL contentCreated;
@end


@implementation PMStartScene

- (void)didMoveToView: (SKView *) view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild: [self newHelloNode]];
}

- (SKLabelNode *)newHelloNode
{
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.name = @"startTextNode";
    helloNode.text = @"Touch Screen To Start";
    helloNode.fontSize = 42;
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    return helloNode;
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)event
{
    NSLog(@"Starting");
    SKNode *helloNode = [self childNodeWithName:@"startTextNode"];
    if (helloNode != nil)
    {
        helloNode.name = nil;
        SKAction *moveUp = [SKAction moveByX: 0 y: 100.0 duration: 0.5];
        SKAction *zoom = [SKAction scaleTo: 1.6 duration: 0.25];
        SKAction *pause = [SKAction waitForDuration: 0.25];
        SKAction *zoomOut = [SKAction scaleTo: 0.1 duration: 0.25];
        SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
        SKAction *remove = [SKAction removeFromParent];
        
        SKAction *moveSequence = [SKAction sequence:@[moveUp, zoom, pause, zoomOut, fadeAway, remove]];
        
        [helloNode runAction: moveSequence completion:^{
            SKScene *spaceshipScene  = [[PMPlayScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
//            [[PMSoundDelegate sharedInstance] playBackgroundMusic:BGM_STAGE1];
            [self.view presentScene:spaceshipScene transition:doors];
        }];
        
        [helloNode runAction: moveSequence];
        
    }
}

@end
