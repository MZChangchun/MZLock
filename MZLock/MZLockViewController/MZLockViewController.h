//
//  MZLockViewController.h
//  test
//
//  Created by Mr.Yang on 2016/9/28.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZLockViewController;
@protocol MZLockViewControllerDelegate <NSObject>

@optional
- (void)lockViewController:(MZLockViewController *)lockViewController lockResult:(BOOL)result;
- (void)lockViewControllerCancel:(MZLockViewController *)lockViewController;

@end


@interface MZLockViewController : UIViewController

typedef NS_ENUM(NSInteger, LockType) {
    MZAddLock = 1,//加锁
    MZUnLock  = 0,//解锁
    MZChLock  = 2 //改锁
};

@property (nonatomic, assign)LockType mzlockType;
@property (nonatomic, strong, readonly)NSMutableString *currentPassWord;
@property (nonatomic, assign)id<MZLockViewControllerDelegate> delegate;

@end
