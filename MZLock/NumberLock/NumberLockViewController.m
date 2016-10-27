//
//  NumberLockViewController.m
//  test
//
//  Created by Mr.Yang on 2016/10/26.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "NumberLockViewController.h"
#import "NumberCipherViewController.h"

@interface NumberLockViewController ()<NumberCipherViewControllerDelegate>

@end

@implementation NumberLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)add:(id)sender {
    NumberCipherViewController * lock = [[NumberCipherViewController alloc] init];
    lock.delegate = self;
    lock.mzlockType = MZAddLock;
    [self presentViewController:lock animated:1 completion:nil];
    
}
- (IBAction)change:(id)sender {
    NumberCipherViewController * lock = [[NumberCipherViewController alloc] init];
    lock.delegate = self;
    lock.mzlockType = MZChLock;
    [self presentViewController:lock animated:1 completion:nil];
}
- (IBAction)unlock:(id)sender {
    NumberCipherViewController * lock = [[NumberCipherViewController alloc] init];
    lock.delegate = self;
    lock.mzlockType = MZUnLock;
    [self presentViewController:lock animated:1 completion:nil];
}

- (void)lockNumberViewControllerCancel:(NumberCipherViewController *)lockViewController {
    [lockViewController dismissViewControllerAnimated:1 completion:nil];
}
- (void)lockNumberViewController:(NumberCipherViewController *)lockViewController lockResult:(BOOL)result {
    NSLog(@"类型： %ld \t结果：%x", (long)lockViewController.mzlockType, result);
    [lockViewController dismissViewControllerAnimated:1 completion:nil];
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
