//
//  ViewController.m
//  HBChatViewDemo
//
//  Created by 季怀斌 on 2019/11/16.
//  Copyright © 2019 季怀斌. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "HBChatViewController.h"
@interface ViewController ()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    //
    UIButton *btn1 = [UIButton new];
    [btn1 sizeToFit];
    [btn1 setTitle:@"chatWithNoHistory" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(chatWithNoHistory) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(100);
    }];
    
    //
   UIButton *btn2 = [UIButton new];
    [btn2 sizeToFit];
    [btn2 setTitle:@"chatWithHistory" forState:UIControlStateNormal];
   [btn2 addTarget:self action:@selector(chatWithHistory) forControlEvents:UIControlEventTouchDragInside];
   [self.view addSubview:btn2];
   [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(self.view);
       make.top.mas_equalTo(200);
   }];
}


- (void)chatWithNoHistory {
    HBChatViewController *chatVCtr = [HBChatViewController new];
    [self.navigationController pushViewController:chatVCtr animated:true];
}

- (void)chatWithHistory {
    HBChatViewController *chatVCtr = [HBChatViewController new];
    for (int i = 0; i < 15; i++) {
        [chatVCtr.dataArr addObject:[NSString stringWithFormat:@"-----%d", i]];
    }
    [self.navigationController pushViewController:chatVCtr animated:true];
}


@end
