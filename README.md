# MZLock
#九宫格加锁解锁控制器
 导入入头文件`#import "MZLockViewController.h"`
 
 添加代理`MZLockViewControllerDelegate`
 
 记得要实现两个代理
 ```
 - (void)lockViewController:(MZLockViewController *)lockViewController lockResult:(BOOL)result {
    NSLog(@"类型： %ld \t结果：%x", (long)lockViewController.mzlockType, result);
    [lockViewController dismissViewControllerAnimated:1 completion:nil];
}
- (void)lockViewControllerCancel:(MZLockViewController *)lockViewController {
    [lockViewController dismissViewControllerAnimated:1 completion:nil];
}
```
 
 使用方法： 
```
 MZLockViewController * lock = [[MZLockViewController alloc] init];
    lock.delegate = self;
    lock.mzlockType = MZChLock;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:lock] animated:1 completion:nil];
```
 其中 `mzlockType`是枚举类型的，用来控制解锁界面的功能,包括以下三种
```
     MZAddLock = 1,//加锁
    MZUnLock  = 0,//解锁
    MZChLock  = 2 //改锁
```
 不过逻辑在未设置密码时不论绘制任何密码，返回结果都是`1`
 有密码却要增加密码时，需要先验证密码
 当然还有删除密码功能，这个其实和解锁功能的逻辑一样，使用解锁类型即可


![image](https://github.com/MZChangchun/MZLock/blob/master/1.png)
![image](https://github.com/MZChangchun/MZLock/blob/master/2.png)
