//
//  StartGameViewController.m
//  PlayMe
//
//  Created by Jon DeJong on 2/13/14.
//  Copyright (c) 2014 Jon DeJong. All rights reserved.
//

#import "StartGameViewController.h"
#import "PMViewController.h"

@interface StartGameViewController ()

@end

@implementation StartGameViewController

- (IBAction)playButtonPressed:(UIButton*)sender
{
    NSLog(@"Play button pressed");
    
    PMViewController *pmViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                                                      @"PMViewController"];
    
    [self.navigationController pushViewController:pmViewController animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
