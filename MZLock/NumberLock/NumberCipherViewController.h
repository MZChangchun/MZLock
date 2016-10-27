//
//  NumberCipherViewController.h
//  别忘密码
//
//  Created by Mr.Yang on 2016/10/25.
//  Copyright © 2016年 MZ. All rights reserved.
//


//需要导入库AudioToolBox.framework 震动使用

#import <UIKit/UIKit.h>

@class NumberCipherViewController;
@protocol NumberCipherViewControllerDelegate <NSObject>

@optional
- (void)lockNumberViewController:(NumberCipherViewController *)lockViewController lockResult:(BOOL)result;
- (void)lockNumberViewControllerCancel:(NumberCipherViewController *)lockViewController;

@end



@interface NumberCipherViewController : UIViewController
typedef NS_ENUM(NSInteger, LockType) {
    MZAddLock = 1,//加锁
    MZUnLock  = 0,//解锁
    MZChLock  = 2 //改锁
};
@property (nonatomic, assign)LockType mzlockType;
@property (nonatomic, strong, readonly)NSMutableString *currentPassWord;
@property (nonatomic, assign)id<NumberCipherViewControllerDelegate> delegate;

@end
