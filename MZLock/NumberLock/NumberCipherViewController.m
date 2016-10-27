//
//  NumberCipherViewController.m
//  别忘密码
//
//  Created by Mr.Yang on 2016/10/25.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "NumberCipherViewController.h"
#import "NumberCipherView.h"
static NSString * const jiesuokeyaboutnumbercipher = @"jiesuokeyaboutnumbercipher";

@interface NumberCipherViewController ()<NumberCipherViewDelegate>

@property (nonatomic, strong)NumberCipherView * lockView;
@property (nonatomic, copy)NSMutableString * tempStr;//存储第一次密码

@end

@implementation NumberCipherViewController

- (NSMutableString *)currentPassWord {
    return [[NSUserDefaults standardUserDefaults] objectForKey:jiesuokeyaboutnumbercipher];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * backImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backImage.image = [UIImage imageNamed:@"Home_refresh_bg"];
    [self.view addSubview:backImage];
    
    //添加高斯模糊
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.view.frame;
    [self.view addSubview:effectView];
    
    
    self.lockView = [[NumberCipherView alloc] initWithPassNumber:6];
    self.lockView.delegate = self;
    [self.view addSubview:self.lockView];
    
    self.lockView.titleMessage = @"请输入密码";
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
        self.lockView.titleMessage = @"请输入原来的密码";
    }
    
}
- (void)NumberCipherResult:(NSMutableString *)str {
    NSLog(@"%@",str);
    NSLog(@"%@",self.currentPassWord);
    if (self.mzlockType == MZAddLock) {
        if (!self.tempStr) {
            self.tempStr = str;
            self.lockView.titleMessage = @"请再次输入你的密码";
            return;
        }
        if ([self.tempStr isEqualToString:str]) {
            //成功
            if (self.delegate && [self.delegate respondsToSelector:@selector(lockNumberViewController:lockResult:)]) {
                [self.delegate lockNumberViewController:self lockResult:1];
            }
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:jiesuokeyaboutnumbercipher];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        } else {
            [self.lockView ErrorTheCipherDouDong];
            self.tempStr = nil;
            self.lockView.titleMessage = @"两次输入的密码不一样，请重新输入";
            return;
        }
        
    } else if (self.mzlockType == MZUnLock) {
        if(!self.currentPassWord) {
            [self NumberCancel];
            return;
        }
        if ([self.currentPassWord isEqualToString:str]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(lockNumberViewController:lockResult:)]) {
                [self.delegate lockNumberViewController:self lockResult:1];
            }
        } else {
            [self.lockView ErrorTheCipherDouDong];
            self.lockView.titleMessage = @"密码错误，请重新输入";
            return;
        }
    } else if (self.mzlockType == MZChLock) {
        if ([self.currentPassWord isEqualToString:str]) {
            self.lockView.titleMessage = @"请输入新密码";
            self.mzlockType = MZAddLock;
        } else {
            [self.lockView ErrorTheCipherDouDong];
            self.lockView.titleMessage = @"密码错误，请重新输入";
        }
    }
}
- (void)NumberCancel {
    if (self.delegate && [self.delegate respondsToSelector:@selector(lockNumberViewControllerCancel:)]) {
        [self.delegate lockNumberViewControllerCancel:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
