//
//  TouchIDManager.m
//  test
//
//  Created by Mr.Yang on 2016/10/24.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "TouchIDManager.h"

@interface TouchIDManager()

@property (nonatomic,strong)TouchIDResult * result;

@end

@implementation TouchIDManager

- (instancetype)initWithBlock:(touchIDCheck)block {
    self = [super init];
    if (self) {
        self.touchCheck = block;
        self.result = [TouchIDResult new];
        [self showTouchID];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.result = [TouchIDResult new];
    }
    return self;
}

- (void)showTouchID {
    if (self.touchCheck == nil) {
        return;
    }
    LAContext * context = [[LAContext alloc] init];
    NSError * error;
    context.localizedCancelTitle = @"我要授权";//取消按钮
    //判断是否支持
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //弹出指纹识别界面
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"你妹的"//显示的消息
                          reply:^(BOOL success, NSError * _Nullable error) {
                              if (success) {
                                  self.result.resultSuccess = true;
                                  NSLog(@"%@,%ld,%d",self.result.reason,(long)self.result.code,self.result.resultSuccess);
                                  self.touchCheck(self.result);
                              } else {
                                  //                                  a++;
                                  
                                  self.result.resultSuccess = false;
                                  self.result.code = error.code;
                                  switch (error.code) {
                                      case LAErrorAuthenticationFailed:
                                          self.result.reason = @"指纹不对";
                                          break;
                                          
                                      case LAErrorUserCancel:
                                          self.result.reason = @"点击了取消";
                                          break;
                                          
                                      case LAErrorUserFallback:
                                          self.result.reason = @"选择了输入密码";
                                          break;
                                          
                                      case LAErrorSystemCancel:
                                          self.result.reason = @"被系统取消";
                                          break;
                                          
                                      case LAErrorTouchIDLockout:
                                          self.result.reason = @"多次错误被锁定";
                                          break;
                                          
                                      case LAErrorAppCancel:
                                          self.result.reason = @"被(突如其来的)应用（电话）取消";//9.0我试了验证过程中电话进来返回的LAErrorSystemCancel错误码不是这个
                                          break;
                                          
                                      default:
                                          break;
                                  }
                                  NSLog(@"%@,%ld,%d",self.result.reason,(long)self.result.code,self.result.resultSuccess);
                                  self.touchCheck(self.result);
                              }
                          }];
    } else {
        self.result.resultSuccess = false;
        self.result.code = error.code;
        switch (error.code) {
            case LAErrorPasscodeNotSet:
                self.result.reason = @"在设置里面没有设置密码";
                break;
                
            case LAErrorTouchIDNotAvailable:
                self.result.reason = @"设备不支持Touch ID";
                break;
                
            case LAErrorTouchIDNotEnrolled:
                self.result.reason = @"在设置里面没有设置TouchId 指纹";
                break;
                
            case LAErrorInvalidContext:
                self.result.reason = @"创建的指纹对象失效";
                break;
                
            default:
                break;
        }
        NSLog(@"%@,%ld,%d",self.result.reason,(long)self.result.code,self.result.resultSuccess);
        self.touchCheck(self.result);
    }

}

- (void)touchIDChecken:(touchIDCheck)block {
    self.touchCheck = block;
    [self showTouchID];
    
}


@end
