//
//  RankViewController.m
//  Mokugyo
//
//  Created by 陽一 岡本 on 12/10/31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RankViewController.h"

@implementation RankViewController
@synthesize cnt;

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBgm];
    
    // NSUserDefaultsからデータを読み込む
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *rankAry = [ud objectForKey:@"RANK"];
    
    // 倒した数が超えていれば挿入
    for (int i=0; i < rankAry.count; i++) {
        if ([[rankAry objectAtIndex:i] intValue] < cnt) {
            NSMutableArray *copyrankAry = [NSMutableArray arrayWithArray:rankAry];
            [copyrankAry removeLastObject];
            [copyrankAry insertObject:[NSString stringWithFormat:@"%d", cnt] atIndex:i];
            rankAry = copyrankAry;
            break;
        }
    }

    // 保存確定
    [ud setObject:rankAry forKey:@"RANK"];
    [ud synchronize];
    
    // 画面表示
    lbl1_.text = [rankAry objectAtIndex:0];
    lbl2_.text = [rankAry objectAtIndex:1];
    lbl3_.text = [rankAry objectAtIndex:2];
}

///**
// * インスタンス解放時
// */
//- (void)dealloc
//{
//    [super dealloc];
//    [bgm_ release];
//    [btnTop_ release];
//    [lbl1_ release];
//    [lbl2_ release];
//    [lbl3_ release];
//}

/**
 * BGMを設定する
 */
- (void)setBgm
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rank" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    bgm_ = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    bgm_.enableRate = YES;
    bgm_.numberOfLoops = -1;
    bgm_.rate = 1.0;
    bgm_.volume = 0.5f;
    [bgm_ play];
}

/**
 * トップボタン押下時
 */
- (IBAction)btnTopClick:(id)sender
{
    [bgm_ stop];
    
    // トップ画面を表示する
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
