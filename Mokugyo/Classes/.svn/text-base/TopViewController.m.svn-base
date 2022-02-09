//
//  TopViewController.m
//  Mokugyo
//
//  Created by 陽一 岡本 on 12/11/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TopViewController.h"
#import "MokugyoViewController.h"
#import "StageViewController.h"
#import "RankViewController.h"

@implementation TopViewController

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserDefaults];
    self.navigationController.navigationBarHidden = YES;
}

///**
// * インスタンス解放時
// */
//- (void)dealloc
//{
//    [super dealloc];
//    [btnSel_ release];
//    [btnCha_ release];
//    [btnRank_ release];
//}

/**
 * NSUserDefaultsの初期設定
 */
- (void)initUserDefaults
{
    // NSUserDefaultsからデータを読み込む
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *rankAry = [ud objectForKey:@"RANK"];
    NSMutableArray *clearAry = [ud objectForKey:@"CLEAR"];
    
    // 最初は値なしのため
    rankAry = rankAry.count <= 0 ? [[NSMutableArray alloc] init] : rankAry;
    clearAry = clearAry.count <= 0 ? [[NSMutableArray alloc] init] : clearAry;
    
    // ステージが追加された場合の対応
    NSInteger addRankCnt = [STAGE_LIST count] - [rankAry count];
    for (int i=0; i < addRankCnt; i++) {
        [rankAry addObject:STAGE_MISS];
    }
    
    NSInteger addClearCnt = [STAGE_LIST count] - [clearAry count];
    for (int i=0; i < addClearCnt; i++) {
        [clearAry addObject:STAGE_MISS];
    }
        
    // 保存確定
    [ud setObject:rankAry forKey:@"RANK"];
    [ud setObject:clearAry forKey:@"CLEAR"];
    [ud synchronize];
}

/**
 * ステージ選択ボタン押下時
 */
- (IBAction)btnSelClick:(id)sender
{
    // メイン画面を表示する
    StageViewController *viewController = [[StageViewController alloc] initWithNibName:@"StageViewController" bundle:nil];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

/**
 * チャレンジボタン押下時
 */
- (IBAction)btnChaClick:(id)sender
{
    // メイン画面を表示する
    MokugyoViewController *viewController = [[MokugyoViewController alloc] initWithNibName:@"MokugyoViewController" bundle:nil];
    viewController.mode = MODE_CHARANGE;
    viewController.stgId = STAGE_1000;
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

/**
 * ランキングボタン押下時
 */
- (IBAction)btnRankClick:(id)sender
{
    // メイン画面を表示する
    RankViewController *viewController = [[RankViewController alloc] initWithNibName:@"RankViewController" bundle:nil];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

@end
