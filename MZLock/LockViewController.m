//
//  LockViewController.m
//  test
//
//  Created by Mr.Yang on 2016/9/28.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "LockViewController.h"
#import "MZLockViewController.h"

@interface LockViewController ()<MZLockViewControllerDelegate>

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)unlock:(id)sender {
    MZLockViewController * lock = [[MZLockViewController alloc] init];
    lock.delegate = self;
    lock.mzlockType = MZUnLock;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:lock] animated:1 completion:nil];
}
- (IBAction)addlock:(id)sender {
    MZLockViewController * lock = [[MZLockViewController alloc] init];
    lock.delegate = self;
    lock.mzlockType = MZAddLock;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:lock] animated:1 completion:nil];
}
- (IBAction)changelock:(id)sender {
    MZLockViewController * lock = [[MZLockViewController alloc] init];
    lock.delegate = self;
    lock.mzlockType = MZChLock;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:lock] animated:1 completion:nil];
}
- (void)lockViewController:(MZLockViewController *)lockViewController lockResult:(BOOL)result {
    NSLog(@"类型： %ld \t结果：%x", (long)lockViewController.mzlockType, result);
    [lockViewController dismissViewControllerAnimated:1 completion:nil];
}
- (void)lockViewControllerCancel:(MZLockViewController *)lockViewController {
    [lockViewController dismissViewControllerAnimated:1 completion:nil];
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
