//
//  PMViewController.m
//  PlayMe
//
//  Created by Jon DeJong on 1/21/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//

#import "PMViewController.h"
#import "PMPlayScene.h"

@implementation PMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [[PMSoundDelegate sharedInstance] playBackgroundMusic:BGM_TITLE];

    SKView *spriteView = (SKView *) self.view;
    spriteView.showsDrawCount = NO;
    spriteView.showsNodeCount = NO;
    spriteView.showsFPS = NO;
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    PMPlayScene* startScene = [[PMPlayScene alloc] initWithSize:CGSizeMake(1024,768)];
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
