//
//  PMViewController.m
//  PlayMe
//
//  Created by Jon DeJong on 1/21/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//

#import "PMViewController.h"
#import "PMMyScene.h"
#import "PMStartScene.h"
#import "PMSoundDelegate.h"

@implementation PMViewController

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    // Configure the view.
//    SKView * skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
//    
//    // Create and configure the scene.
//    SKScene * scene = [PMStartScene sceneWithSize:skView.bounds.size];
//    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    // Present the scene.
//    [skView presentScene:scene];
//}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [[PMSoundDelegate sharedInstance] playBackgroundMusic:BGM_TITLE];
	// Do any additional setup after loading the view, typically from a nib.
    SKView *spriteView = (SKView *) self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    PMStartScene* startScene = [[PMStartScene alloc] initWithSize:CGSizeMake(1024,768)];
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene: startScene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
