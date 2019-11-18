//
//  ViewController.m
//  HBChatViewDemo
//
//  Created by 季怀斌 on 2019/11/16.
//  Copyright © 2019 季怀斌. All rights reserved.
//

#import "HBChatViewController.h"
#import "Masonry.h"
#import "HBChatCell.h"
#import "HBChatTableView.h"
@interface HBChatViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) HBChatTableView *tableView;
@property (nonatomic, strong) UIView *keybordView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) CGFloat tableViewContentHeight;
@end

@implementation HBChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.
    [self setSubViews];
   
    //2.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameChanged:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameChanged:) name:UIKeyboardWillHideNotification object:nil];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *textStr = textField.text;
    if (textStr && [textStr stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0) {
        [self.dataArr addObject:textStr];
        [self.tableView reloadData];
        textField.text = @"";
                
        CGFloat bottom = [UIScreen mainScreen].bounds.size.height - self.keyboardHeight - self.keybordView.bounds.size.height;
     
        
        HBChatCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArr count] - 1  inSection:0]];
        CGFloat tableViewContentHeight = CGRectGetMaxY(cell.frame) + 64;

        if (tableViewContentHeight > bottom) {
            self.tableViewContentHeight = tableViewContentHeight;
        }
        NSLog(@"------ssss----:%lf------------:%lf", bottom, self.tableViewContentHeight);
        
           [UIView animateWithDuration:self.duration delay:0 options:7 << 16 animations:^{
               //
               [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArr count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:false];
           } completion:nil];

    }
    
    return true;
}



- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)keyBoardFrameChanged:(NSNotification *)notification {
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.duration = duration;
    if (notification.name == UIKeyboardWillShowNotification) {
        CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardHeight = rect.size.height;
        
        //
        self.keyboardHeight = keyboardHeight;
        CGFloat bottom = [UIScreen mainScreen].bounds.size.height - self.keyboardHeight - self.keybordView.bounds.size.height;
        //
        [UIView animateWithDuration:duration delay:0 options:7 << 16 animations:^{
            
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.height.mas_equalTo(bottom);
            }];
            
          
            if (self.tableViewContentHeight > bottom) {
                [self.tableView layoutIfNeeded];
                if ([self.dataArr count] > 0) {
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArr count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:true];
                }
                [self.tableView layoutIfNeeded];
            }
            
            self.keybordView.transform = CGAffineTransformMakeTranslation(0, - keyboardHeight);
        } completion:nil];
        
        
                   
        
        
    } else if (notification.name == UIKeyboardWillHideNotification) {
        // 清空transform
        [UIView animateWithDuration:duration delay:0 options:7 << 16 animations:^{
            
            self.keybordView.transform = CGAffineTransformIdentity;
            CGFloat bottom = [UIScreen mainScreen].bounds.size.height - self.keybordView.bounds.size.height;
          
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                  make.height.mas_equalTo(bottom);
            }];
            
            if ([self.dataArr count] > 0) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArr count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:false];
            }
        } completion:nil];
        
        self.keyboardHeight = 0;
    }
    
//    NSLog(@"--------rrrrr-----:%lf", self.tableView.bounds.size.height);
    
}

- (void)setSubViews {
    
     [self.view addSubview:self.tableView];
    [self.view addSubview:self.keybordView];
   
    
    [self.keybordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.09);
      }];
       
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.keybordView);
        make.top.left.mas_equalTo(10);
    }];
    
    
    CGFloat height = [self.dataArr count] ? self.view.bounds.size.height * 0.91 : 0;
   [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.right.mas_equalTo(0);
       make.height.mas_equalTo(height);
   }];
}


- (HBChatTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[HBChatTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.backgroundColor = [UIColor greenColor];
        //
        __weak typeof(self) WeakSelf = self;
        _tableView.touchBlock = ^{
            [WeakSelf.textField resignFirstResponder];
        };
    }
    return _tableView;
}


- (UIView *)keybordView {
    if (_keybordView == nil) {
        _keybordView = [UIView new];
        _keybordView.backgroundColor = [UIColor lightGrayColor];
//        _keybordView.alpha = 0.6;
        [_keybordView addSubview:self.textField];
    }
    return _keybordView;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.returnKeyType = UIReturnKeySend;
        _textField.enablesReturnKeyAutomatically = true;
        _textField.placeholder = @"请输入...";
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.delegate = self;
    }
    return _textField;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBChatCell *cell = [HBChatCell cellWithTableView:tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"---%@", [self.dataArr objectAtIndex:indexPath.row]];
    return cell;
}


@end
