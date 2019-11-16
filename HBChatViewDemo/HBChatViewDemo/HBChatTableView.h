//
//  HBChatTableView.h
//  HBChatViewDemo
//
//  Created by 季怀斌 on 2019/11/16.
//  Copyright © 2019 季怀斌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBChatTableView : UITableView
@property (nonatomic, copy) void(^touchBlock)(void);
@end

NS_ASSUME_NONNULL_END
