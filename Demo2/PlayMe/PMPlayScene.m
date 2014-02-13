//
//  PMPlayScene.m
//  PlayMe
//
//  Created by Jon DeJong on 2/4/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//

#import "PMPlayScene.h"
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(uint32_t, PMPhysicsCategory) {
    PMHoopyCat = 1 << 0, // 0001 = 1
    PMZombieCat = 1 << 1, // 0010 = 2
    PMEdgeCat = 1 << 2, // 0100 = 4
};

@interface PMPlayScene ()<SKPhysicsContactDelegate>
@property BOOL contentCreated;
@end

@implementation PMPlayScene {
@private
    SKTextureAtlas* _atlas;
    SKTexture* _hoopyTexture;
    SKTexture* _zombieTexture;
    SKLabelNode * _hitLabel;
    int _hits;
}

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

-(void) didBeginContact:(SKPhysicsContact *)contact
{
    NSString * aName = contact.bodyA.node.name;
    NSString * bName = contact.bodyB.node.name;
    NSLog(@"Contact between %@ and %@", aName, bName);
    [self didRegisterHit];
}

-(void) didRegisterHit
{
    _hitLabel.text = [NSString stringWithFormat:@"Hits: %d", ++_hits];
}

-(void) didEndContact:(SKPhysicsContact *)contact
{
    NSLog(@"end contact");
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    SKNode *hoopy = [self findHoopy];
    
    CGPoint offset = CGPointMake(touchLocation.x - hoopy.position.x, touchLocation.y - hoopy.position.y);
    CGFloat length = sqrtf(offset.x * offset.x + offset.y * offset.y);
    
    [hoopy.physicsBody applyImpulse: CGVectorMake(offset.x/length * HOOPY_THRUST, offset.y/length * HOOPY_THRUST)];
}

- (void)createSceneContents
{
    // Get the textures
    _atlas = [SKTextureAtlas atlasNamed:@"gameTextures"];
    _hoopyTexture = [_atlas textureNamed:@"red_ball.png"];
    _zombieTexture = [_atlas textureNamed:@"zombie.png"];
    _hits = 0;
    
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    // Add edge physics body for the border
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.contactDelegate = self;
    self.physicsBody.categoryBitMask = PMEdgeCat;
    
    [self addBackground];
    
    // Add zombie
    [self addZombie];
    
    // Add Hoopy
    [self addHoopy];
    
    // Add Lable
    _hitLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier Bold" ];
    _hitLabel.position = CGPointMake(100, 700);
    _hitLabel.fontSize = 40.0;
    _hitLabel.fontColor = [SKColor blackColor];
    _hitLabel.text = @"Hits: 0";
    [self addChild:_hitLabel];
    
    SKAction *readdHoopy = [SKAction sequence: @[
                                                 [SKAction performSelector:@selector(readdHoopy) onTarget:self],
                                                 [SKAction waitForDuration:2]
                                                 ]];
    [self runAction: [SKAction repeatActionForever:readdHoopy]];
}

-(void) addBackground
{
    self.backgroundColor = [SKColor colorWithRed:206 green:206 blue:206 alpha:1.0];
    self.scaleMode = SKSceneScaleModeAspectFit;
}

-(void)readdHoopy
{
    SKNode* node = [self findHoopy];
    
    //If hoopy is off the screen, add another
    if(node.position.y < 0 || node.position.y > 768 || node.position.x < 0 || node.position.x > 1024) {
        [node removeFromParent];
        [self addHoopy];
    }
    
}

-(SKNode *) findHoopy
{
    __block SKNode *hoopy = nil;
    [self enumerateChildNodesWithName:@"hoopy" usingBlock:^(SKNode *node, BOOL *stop) {
        hoopy = node;
    }];
    return hoopy;
}
     
-(void)addHoopy
{
    SKSpriteNode *hoopy = [SKSpriteNode spriteNodeWithTexture:_hoopyTexture];
    hoopy.name = @"hoopy";

    hoopy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:hoopy.size.width/2];
    hoopy.physicsBody.dynamic = YES;
    hoopy.physicsBody.restitution = 1.0;
    hoopy.physicsBody.categoryBitMask = PMHoopyCat;
    hoopy.physicsBody.collisionBitMask = PMZombieCat | PMEdgeCat;
    
    hoopy.position = CGPointMake(self.size.width/2, self.size.height-50);
    
    [self addChild:hoopy];
}

- (SKSpriteNode *)addZombie
{
    SKSpriteNode *zombie = [SKSpriteNode spriteNodeWithTexture:_zombieTexture];
    zombie.name = @"zombie";
    
    zombie.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:zombie.size];
//    zombie.physicsBody.dynamic = YES;
    zombie.physicsBody.dynamic = NO;
//    zombie.physicsBody.allowsRotation = YES;
    zombie.physicsBody.allowsRotation = NO;
    zombie.physicsBody.categoryBitMask = PMZombieCat;
    zombie.physicsBody.collisionBitMask = PMHoopyCat | PMEdgeCat;
    zombie.physicsBody.contactTestBitMask = PMHoopyCat;
    
    float xMove = 1024-zombie.size.width;
    
    SKAction *move = [SKAction sequence:@[
                                          [SKAction moveByX:xMove y:0 duration:10.0],
                                          [SKAction moveByX:-xMove y:0 duration:10.0]]];
    [zombie runAction: [SKAction repeatActionForever:move]];
    
    zombie.position = CGPointMake(zombie.size.width/2, zombie.size.height/2);
    [self addChild:zombie];
    
    return zombie;
}

@end