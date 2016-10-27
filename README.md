# MZLock
## 1.九宫格加锁解锁控制器 
 文件夹 `DrawLock`
 导入入头文件`#import "MZLockViewController.h"`
 将文件夹 `View`里面的图片加入到 `Assets` 里面，当然你也可以使用自己的图片
 
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

## 2.TouchID
引入`“LocalAuthentication”`这个库
文件夹`TouchIDLock`
导入 `#import "TouchIDManager.h"`
使用block
```
TouchIDManager * manger = [TouchIDManager new];
    [manger touchIDChecken:^(TouchIDResult *result) {
        if (result.resultSuccess) {
                            NSLog(@"验证通过");
                        } else {
                            NSLog(@"%@", result.reason);
                        }
    }];
```
    有木有比代理更简单啊！
    
## 3.数字密码盘
仿iOS解锁界面
导入库`AudioToolBox.framework `震动使用
导入头文件`#import "NumberCipherViewController.h"`
使用方法和 `1.九宫格加锁解锁控制器 `一样，不做赘述。
