//
//  PMViewController.m
//  PlayMe
//
//  Created by Jon DeJong on 1/21/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//

#import "PMViewController.h"
#import "PMPlayScene.h"
#import "PMPlayMe.h"

@interface PMViewController() <UIAlertViewDelegate>

@end

@implementation PMViewController

- (void)gameOver
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Game over"
                          message:[NSString stringWithFormat:@"You hit the zombie %d times!", MAX_HITS_ALLOWED]
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self goBack:alert];
}

- (void)goBack:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    PMPlayScene* playScene = [[PMPlayScene alloc] initWithSize:CGSizeMake(1024,768)];
    
    __weak PMViewController *weakSelf = self;
    playScene.gameOverBlock = ^(){
        [weakSelf gameOver];
    };
    
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene: playScene];
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
