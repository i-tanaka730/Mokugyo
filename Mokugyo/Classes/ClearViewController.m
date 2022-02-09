//
//  ClearViewController.m
//  Mokugyo
//
//  Created by 田中郁也 on 2012/11/21.
//
//

#import "ClearViewController.h"

@implementation ClearViewController
@synthesize clearId, stgId;

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    // BGM
    [self setBgm];
    
    // メッセージ
    if ([clearId intValue] == [STAGE_CLEAR intValue]) {
        lblMsg_.text = @"ステージクリア！\nおめでとう！";
        [lblMsg_ setTextColor:[UIColor redColor]];

        iv_.image = [UIImage imageNamed:@"naku_obake_white.png"];
        
        // NSUserDefaultsからデータを読み込む
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSMutableArray *clearAry = [NSMutableArray arrayWithArray:[ud objectForKey:@"CLEAR"]];
        
        // クリアにする
        [clearAry replaceObjectAtIndex:stgId withObject:STAGE_CLEAR];
        
        // 保存確定
        [ud setObject:clearAry forKey:@"CLEAR"];
        [ud synchronize];
        
    } else {
        lblMsg_.text = @"残念・・・";
        [lblMsg_ setTextColor:[UIColor blueColor]];
    }
}

///**
// * インスタンス解放時
// */
//- (void)dealloc
//{
//    [super dealloc];
//    [bgm_ release];
//    [btnTop_ release];
//    [lblMsg_ release];
//    [iv_ release];
//}

/**
 * BGMを設定する
 */
- (void)setBgm
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"clear" ofType:@"mp3"];
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
