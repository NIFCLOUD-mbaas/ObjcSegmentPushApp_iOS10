//
//  ViewController.m
//  ObjcSegmentPushApp
//
//  Created by Nifty on 2016/10/17.
//  Copyright © 2016年 Nifty. All rights reserved.
//

#import "ViewController.h"
#import "AppSetting.h"
#import <NCMB/NCMB.h>

#import "CustomCell.h"
#import "ConvertString.h"

/**
 追加fieldのマネージャー　（表示用の一時保存）
 keyの値を変更する場合があるので、追加fieldは保存ボタン時にinstallationに登録する
 */
@interface AddFieldManager : NSObject

@property (nonatomic) NSString *keyStr;
@property (nonatomic) NSString *valueStr;

@end

@implementation AddFieldManager
@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UITableView *tableView;

@property (nonatomic) NCMBInstallation *installation;
// currentInstallationに登録されているkeyの配列
@property (nonatomic) NSArray *instKeys;
// installationに初期で登録されているキー
@property (nonatomic) NSArray *initialInstKeys;
// 追加セルのマネージャー
@property (nonatomic) AddFieldManager *addFieldManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // installationの初期化
    self.installation = [NCMBInstallation currentInstallation];
    self.instKeys = [self.installation allKeys];
    self.initialInstKeys = @[@"objectId",@"appVersion",@"badge",@"deviceToken",@"sdkVersion",@"timeZone",@"createDate",@"updateDate",@"deviceType",@"applicationName",@"acl"];
    // 追加セルのマネージャーの初期化
    self.addFieldManager = [[AddFieldManager alloc]init];
    
    // トップ画面表示用タイトル
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"CurrentInstallation";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:28.0f];
    
    // tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor]; // グリッド線を消す
    self.tableView.allowsSelection = NO; // セルを選択できないようにする
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.tableView];
    
    // キーボードのイベント設定
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // タップジェスチャーを実装
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
    [self.view addGestureRecognizer:tapGesture];
    
    // installationを取得
    [self getInstallation];
    
}

/**
 最新のinstallationを取得します。
 */
- (void)getInstallation {
    
    //端末情報をデータストアから取得
    [self.installation fetchInBackgroundWithBlock:^(NSError *error) {
        if(!error){
            //端末情報の取得が成功した場合の処理
            NSLog(@"取得に成功");
            self.instKeys = [self.installation allKeys];
            // 追加fieldの値を初期化する
            self.addFieldManager.keyStr = @"";
            self.addFieldManager.valueStr = @"";
            [self.tableView reloadData];
        } else {
            //端末情報の取得が失敗した場合の処理
            NSLog(@"登録に失敗");
        }
    }];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height / 5.0f);
    self.tableView.frame = CGRectMake(0.0f, self.titleLabel.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.titleLabel.frame.size.height);
    
}

#pragma -mark TableViewDataSource

/**
 TableViewのheaderの高さを返します。
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TABLE_VIEW_HEADER_HEIGHT;
}

/**
 TableViewのheaderViewを返します。
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, TABLE_VIEW_HEADER_HEIGHT)];
    if (section == 0) {
        headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, TABLE_VIEW_KEY_LABEL_WIDTH, TABLE_VIEW_HEADER_HEIGHT)];
        keyLabel.text = @"key";
        keyLabel.textAlignment = NSTextAlignmentCenter;
        keyLabel.font = [UIFont systemFontOfSize:12.0f];
        
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(TABLE_VIEW_KEY_LABEL_WIDTH, 0.0f, TABLE_VIEW_VALUE_LABEL_WIDTH, TABLE_VIEW_HEADER_HEIGHT)];
        valueLabel.text = @"value";
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.font = [UIFont systemFontOfSize:12.0f];
        
        [headerView addSubview:keyLabel];
        [headerView addSubview:valueLabel];
    }
    return headerView;
}

/**
 TableViewのCellの数を設定します。
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.instKeys.count + 1;
}

/**
 TableViewのCellの高さを設定します。
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.instKeys.count) {
        return TABLE_VIEW_POST_BTN_CELL_HEIGHT;
    }
    
    return TABLE_VIEW_CELL_HEIGHT;
}

/**
 TableViewのCellを返します。
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomCell *cell;
    
    if (indexPath.row < self.instKeys.count) {
        // 最後のセル以外
        NSString *keyStr = self.instKeys[indexPath.row];
        NSString *valueStr = [self.installation objectForKey:self.instKeys[indexPath.row]];
        
        if (![self.initialInstKeys containsObject:keyStr]) {
            // 既存フィールド以外とchannelsはvalueを編集できるようにする
            NSString *cellIdentifier = @"editCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell){
                cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setCellWithKey:keyStr editValue:valueStr];
            cell.valueField.delegate = self;
            cell.valueField.tag = indexPath.row;
        } else {
            // 編集なしのセル (表示のみ)
            NSString *cellIdentifier = @"nomalCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell){
                cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setCellWithKey:keyStr value:valueStr];
        }
    } else {
        // 最後のセルは追加用セルと登録ボタンを表示
        NSString *cellIdentifier = @"AddCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setAddRecordCell];
        cell.keyField.delegate = self;
        cell.keyField.tag = indexPath.row;
        cell.keyField.text = self.addFieldManager.keyStr ? self.addFieldManager.keyStr : @"";
        cell.valueField.delegate = self;
        cell.valueField.tag = indexPath.row;
        cell.valueField.text = self.addFieldManager.valueStr ? self.addFieldManager.valueStr : @"";
        [cell.registBtn addTarget:self action:@selector(registBtnDidPush:) forControlEvents:UIControlEventTouchUpInside];
    }

    return cell;
}

/**
 登録ボタンをタップした時に呼ばれます
 */
- (void)registBtnDidPush:(id)sender {
    
    // 追加用セル
    if (self.addFieldManager.keyStr && ![self.addFieldManager.keyStr isEqualToString:@""]) {
        // keyに値が設定されていた場合
        if ([self.addFieldManager.valueStr rangeOfString:@","].location != NSNotFound) {
            // value文字列に[,]がある場合は配列に変換してinstallationにセットする
            [self.installation setObject:[self.addFieldManager.valueStr componentsSeparatedByString:@","] forKey:self.addFieldManager.keyStr];
        } else {
            [self.installation setObject:self.addFieldManager.valueStr forKey:self.addFieldManager.keyStr];
        }
    }
    
    
    [self.installation saveInBackgroundWithBlock:^(NSError *error) {
        if(!error){
            NSLog(@"保存に成功");
            // installationの
            [self getInstallation];
        } else {
            NSLog(@"保存に失敗");
        }
    }];
}

// キーボード表示時に画面タップでキーボードを閉じる
- (void)tapScreen:(UITapGestureRecognizer *)sencder {
    [self.view endEditing:YES];
}

#pragma -mark TextFieldDelegate
// キーボードの「Return」押下時の処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // キーボードを閉じる
    [textField resignFirstResponder];
    
    return YES;
}

/**
 textFieldの編集が終了したら呼ばれます
 */
-(void)textFieldDidEndEditing:(UITextField*)textField {
    // tableViewのdatasorceを編集する
    if (textField.tag < self.instKeys.count) {
        // 最後のセル以外はinstallationを更新する
        NSString *instValueStr = [ConvertString convertNSStringToAnyObject:[self.installation objectForKey:self.instKeys[textField.tag]]];
        if (![instValueStr isEqualToString:textField.text]) {
            // valueの値に変更がある場合はinstallationを更新する
            if ([textField.text rangeOfString:@","].location != NSNotFound) {
                // value文字列に[,]がある場合は配列に変換してinstallationにセットする
                [self.installation setObject:[textField.text componentsSeparatedByString:@","] forKey:self.instKeys[textField.tag]];
            } else {
                [self.installation setObject:textField.text forKey:self.instKeys[textField.tag]];
            }
        }
    } else {
        // 追加セルはmanagerクラスを更新する（installation更新時に保存する）
        CustomCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
        if ([textField isEqual:cell.keyField]) {
            // keyFieldの場合
            if (![self.addFieldManager.keyStr isEqualToString:textField.text]) {
                // keyの値に変更がある場合はマネージャーを更新する
                self.addFieldManager.keyStr = textField.text;
            }
        } else {
            // valueFieldの場合
            if (![self.addFieldManager.valueStr isEqualToString:textField.text]) {
                // valueの値に変更がある場合はマネージャーを更新する
                self.addFieldManager.valueStr = textField.text;
            }
        }
    }
}

#pragma -mark keyboard

- (void)keyboardWillShow:(NSNotification*)notification {

    CGRect keyboardRect = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [[self.view superview] convertRect:keyboardRect fromView:nil];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    //アニメーションでtextFieldを動かす
    [UIView animateWithDuration:[duration doubleValue]
                     animations:^{
                         CGRect rect = self.tableView.frame;
                         rect.origin.y = keyboardRect.origin.y - self.tableView.frame.size.height;
                         self.tableView.frame = rect;
                     } ];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    //アニメーションでtextFieldを動かす
    [UIView animateWithDuration:[duration doubleValue]
                     animations:^{
                         CGRect rect = self.tableView.frame;
                         rect.origin.y = self.view.frame.size.height- self.tableView.frame.size.height;
                         self.tableView.frame = rect;
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
