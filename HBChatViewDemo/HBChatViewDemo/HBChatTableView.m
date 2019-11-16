//
//  HBChatTableView.m
//  HBChatViewDemo
//
//  Created by 季怀斌 on 2019/11/16.
//  Copyright © 2019 季怀斌. All rights reserved.
//

#import "HBChatTableView.h"

@implementation HBChatTableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.touchBlock) {
        self.touchBlock();
    }
}

@end
