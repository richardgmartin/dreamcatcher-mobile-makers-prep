//
//  DetailViewController.m
//  DreamCatcher
//
//  Created by Richard Martin on 2015-12-03.
//  Copyright © 2015 richard martin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleString;
    self.textView.text = self.descriptionString;
    
    
}




@end
