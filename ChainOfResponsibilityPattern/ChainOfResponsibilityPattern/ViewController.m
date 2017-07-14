//
//  ViewController.m
//  ChainOfResponsibilityPattern
//
//  Created by YouXianMing on 15/10/27.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "ViewController.h"
#import "HeadChain.h"
#import "PhoneNumChain.h"
#import "EmailChain.h"
#import "UserNameChain.h"
#import "EndChain.h"

@interface ViewController ()

@property (nonatomic, strong) id <ChainOfResponsibilityProtocol> headChain;
@property (nonatomic, strong) id <ChainOfResponsibilityProtocol> phoneNumChain;
@property (nonatomic, strong) id <ChainOfResponsibilityProtocol> emailChain;
@property (nonatomic, strong) id <ChainOfResponsibilityProtocol> userNameChain;
@property (nonatomic, strong) id <ChainOfResponsibilityProtocol> endChain;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    // 创建责任链对象
    // 创建对象数据模型构造器
    self.headChain     = [[HeadChain alloc] init];
    self.phoneNumChain = [[PhoneNumChain alloc] init];
    self.emailChain    = [[EmailChain alloc] init];
    self.userNameChain = [[UserNameChain alloc] init];
    self.endChain      = [[EndChain alloc] init];
    
    // 链接责任链
    self.headChain.successor     = self.phoneNumChain;
    self.phoneNumChain.successor = self.emailChain;
    self.emailChain.successor    = self.userNameChain;
    self.userNameChain.successor = self.endChain;
    
    // 处理事件
    [self.headChain handlerRequest:@"---" finishHandle:^(NSString *string) {
        [self viewBuilder:string];
    }];
    [self.headChain handlerRequest:@"705786230" finishHandle:^(NSString *string) {
        [self viewBuilder:string];
    }];
    [self.headChain handlerRequest:@"15910514636" finishHandle:^(NSString *string) {
        [self viewBuilder:string];
    }];
    [self.headChain handlerRequest:@"705786299@qq.com" finishHandle:^(NSString *string) {
        [self viewBuilder:string];
    }];
}

- (void)viewBuilder:(NSString *)string {
    NSLog(@"str:%@",string);
    if ([string isEqualToString:@"1"]) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        subView.backgroundColor = [UIColor redColor];
        [self.view addSubview:subView];
    }else if ([string isEqualToString:@"2"]) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(60, 60, 50, 50)];
        subView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:subView];
    }else if ([string isEqualToString:@"3"]) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(110, 110, 50, 50)];
        subView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:subView];
    }
}

@end
