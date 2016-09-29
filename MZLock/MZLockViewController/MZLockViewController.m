//
//  MZLockViewController.m
//  test
//
//  Created by Mr.Yang on 2016/9/28.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "MZLockViewController.h"
#import "MZLockView.h"
static NSString * const jiesuokeyaboutuserdefault = @"jiesuokeyaboutuserdefault";

@interface MZLockViewController ()<MZLockViewDelegate>

@property (nonatomic, strong)MZLockView * lockView;
@property (nonatomic, copy)NSMutableString * tempStr;//存储第一次团

@end

@implementation MZLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * backImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backImage.image = [UIImage imageNamed:@"Home_refresh_bg"];
    [self.view addSubview:backImage];
    
    [self.navigationItem setTitle:@"选择您的图案"];
    
    //返回按钮
    UIButton * butt = [UIButton buttonWithType:UIButtonTypeCustom];
    butt.frame = CGRectMake(0, 40.0, 30.0, 30.0);
    [butt setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(cancelButtonDown) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:butt];
    self.navigationItem.leftBarButtonItem = left;
    
    self.lockView = [[MZLockView alloc] init];
    self.lockView.delegate = self;
    self.lockView.center = self.view.center;
    [self.view addSubview:self.lockView];
    
    if (self.mzlockType == MZAddLock) {
        if (self.currentPassWord) {
            self.mzlockType = MZChLock;
        }
    } else if (self.mzlockType == MZChLock) {
        if (!self.currentPassWord) {
            self.mzlockType = MZAddLock;
        }
    }
    if (self.mzlockType == MZChLock) {
        self.navigationItem.title = @"请输入你原来的图案";
    }
}

- (NSMutableString *)currentPassWord {
    return [[NSUserDefaults standardUserDefaults] objectForKey:jiesuokeyaboutuserdefault];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)MZLockResult:(NSMutableString *)str {
    if (self.mzlockType == MZAddLock) {
        if (!self.tempStr) {
            self.tempStr = str;
            self.navigationItem.title = @"请再次输入你的图案";
            return;
        }
        if ([self.tempStr isEqualToString:str]) {
            //成功
            if (self.delegate && [self.delegate respondsToSelector:@selector(lockViewController:lockResult:)]) {
                [self.delegate lockViewController:self lockResult:1];
            }
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:jiesuokeyaboutuserdefault];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        } else {
            self.tempStr = nil;
            self.navigationItem.title = @"两次图案不匹配，请重新绘制";
            return;
        }
        
    } else if (self.mzlockType == MZUnLock) {
        if (!self.currentPassWord) {
            [self cancelButtonDown];
            return;
        }
        if ([self.currentPassWord isEqualToString:str]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(lockViewController:lockResult:)]) {
                [self.delegate lockViewController:self lockResult:1];
            }
        } else {
            self.navigationItem.title = @"密码错误，请重新绘制";
            return;
        }
        
    } else if (self.mzlockType == MZChLock) {
        if ([self.currentPassWord isEqualToString:str]) {
            self.navigationItem.title = @"请绘制你的新图案";
            self.mzlockType = MZAddLock;
        } else {
            self.navigationItem.title = @"密码错误，请重新绘制";
        }
    }
    NSLog(@"%@", str);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        self.navigationItem.title = @"完成后松开手指";
}

- (void)cancelButtonDown {
    if (_delegate && [_delegate respondsToSelector:@selector(lockViewControllerCancel:)]) {
        [_delegate lockViewControllerCancel:self];
    }
}
@end
