//
//  PMViewController.m
//  PlayMe
//
//  Created by Jon DeJong on 1/21/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//

#import "PMViewController.h"
#import "PMStartScene.h"

@implementation PMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [[PMSoundDelegate sharedInstance] playBackgroundMusic:BGM_TITLE];

    SKView *spriteView = (SKView *) self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
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
