//
//  HBChatCell.m
//  HBChatViewDemo
//
//  Created by 季怀斌 on 2019/11/16.
//  Copyright © 2019 季怀斌. All rights reserved.
//

#import "HBChatCell.h"

@implementation HBChatCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpSubViews {
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUpSubViewsContent];
    
    //
}

- (void)setUpSubViewsContent {
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    return cell;
}
@end
