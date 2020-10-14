//
//  ViewController.h
//  ObjcSegmentPushApp
//
//  Created by FUJITSU CLOUD TECHNOLOGIES on 2016/10/17.
//  Copyright 2020 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import <NCMB/NCMB.h>

@interface ViewController : UIViewController

// installation
@property (nonatomic) NCMBInstallation *installation;
// 通信結果を表示するラベル
@property (nonatomic) UILabel *statusLabel;
/**
 最新のinstallationを取得します。
 */
- (void)getInstallation;

@end

