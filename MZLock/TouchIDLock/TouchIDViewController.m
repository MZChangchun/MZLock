//
//  TouchIDViewController.m
//  test
//
//  Created by Mr.Yang on 2016/10/24.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "TouchIDViewController.h"
#import "TouchIDManager.h"


@interface TouchIDViewController ()

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//加锁
- (IBAction)jiasuo:(id)sender {
//    TouchIDManager * manager = [[TouchIDManager alloc] initWithBlock:^(TouchIDResult *result) {
//        if (result.resultSuccess) {
//                NSLog(@"验证通过");
//            } else {
//                NSLog(@"%@", result.reason);
//            }
//    }];
    TouchIDManager * manger = [TouchIDManager new];
    [manger touchIDChecken:^(TouchIDResult *result) {
        if (result.resultSuccess) {
                            NSLog(@"验证通过");
                        } else {
                            NSLog(@"%@", result.reason);
                        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
