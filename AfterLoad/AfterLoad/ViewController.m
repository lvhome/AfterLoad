//
//  ViewController.m
//  AfterLoad
//
//  Created by 吕洪建 on 2018/10/27.
//  Copyright © 2018年 吕洪建. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer * timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 performSelector
    NSLog(@"延迟之前");
    [self performSelector:@selector(performSelectorMa) withObject:self afterDelay:2];
    
    //取消performSelector 延迟方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //取消延迟的某个方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(perform) object:nil];
    
    //2 NSTimer
//    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAfter) userInfo:nil repeats:NO];
    //3 sleep
//    [NSThread sleepForTimeInterval:2];
    
    //4 GCD
    
    /**
      DISPATCH_TIME_NOW 延迟从当前时间开始
      int64_t 延迟的时间
     */
    __weak typeof (self) weakSelf = self;
    int64_t time = 3;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf gcdAfter];//防止循环引用
    });
    
    NSLog(@"延迟方法之后");

}

- (void)performSelectorMa {
    NSLog(@"perform延迟了");
}

- (void)timerAfter {
    NSLog(@"timer延迟了");
    [timer invalidate];//关闭定时器

}

- (void)gcdAfter {
    NSLog(@"gcd延迟加载");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
