//
//  CustomCell.h
//  ObjcSegmentPushApp
//
//  Created by Nifty on 2016/10/18.
//  Copyright © 2016年 Nifty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic) UILabel *keyLabel;
@property (nonatomic) UILabel *valueLabel;

@property (nonatomic) UITextField *keyField;
@property (nonatomic) UITextField *valueField;
@property (nonatomic) UIButton *registBtn;

- (void)setCellWithKey:(NSString *)keyStr value:(id)valueStr;
- (void)setCellWithKey:(NSString *)keyStr editValue:(id)valueStr;
- (void)setAddRecordCell;

@end
