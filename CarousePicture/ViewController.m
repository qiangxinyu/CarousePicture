//
//  ViewController.m
//  CarousePicture
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "HomePageHeaderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HomePageHeaderViewController * vc = [[HomePageHeaderViewController alloc] init];

    [self.view addSubview:vc.view];
    
    NSMutableArray * array = @[].mutableCopy;
    for (int i = 0 ; i < 10; i ++) {
        if (i == 9) {
            [array addObject:@"010.png"];
            break;
        }
        
        NSString * imageName = [NSString stringWithFormat:@"00%d",i+1];
        UIImage * image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
        
        if (!image) {
            [array addObject:[imageName stringByAppendingString:@".jpg"]];
        } else {
            [array addObject:[imageName stringByAppendingString:@".png"]];
        }
    }
    
    vc.groupArray = array.copy;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
