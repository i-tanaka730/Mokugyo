//
//  StageViewController.m
//  Mokugyo
//
//  Created by 田中郁也 on 2012/11/20.
//
//

#import "StageViewController.h"
#import "MokugyoViewController.h"

@implementation StageViewController

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBgm];
    [self setStage];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    clearAry_ = [ud objectForKey:@"CLEAR"];
    table_.separatorColor = [UIColor blueColor];
}

///**
// * インスタンス解放時
// */
//- (void)dealloc
//{
//    [super dealloc];
//    [bgm_ release];
//    [table_ release];
//    [stageTitle_ release];
//    [clearAry_ release];
//}

/**
 * BGMを設定する
 */
- (void)setBgm
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stage" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    bgm_ = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    bgm_.enableRate = YES;
    bgm_.numberOfLoops = -1;
    bgm_.rate = 1.0;
    bgm_.volume = 0.5f;
    [bgm_ play];
}

/**
 * ステージ名設定
 */
- (void)setStage
{
    stageTitle_ = [[NSMutableArray alloc] init];
    for (int i=0; i<[STAGE_LIST count]; i++) {
        [stageTitle_ addObject:STAGE_LIST[i]];
    }
}

/**
 * リストの行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [stageTitle_ count];
}

/**
 * リストにCGIより取得した値を表示する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // テーブルビューのセルに表示する
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];

    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
	cell.textLabel.numberOfLines = 0;
    
    if ([[clearAry_ objectAtIndex:indexPath.row] intValue] == 1) {
        UILabel *lbl = [[UILabel alloc] init];
        lbl.frame = CGRectMake(45, 70, 45, 40);
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor redColor];
        lbl.font = [UIFont fontWithName:@"DBLCDTempBlack" size:18];
        lbl.text = @"★";
        cell.accessoryView = lbl;
    }
    NSString *str = [NSString stringWithFormat:@"%@", [stageTitle_ objectAtIndex:indexPath.row]];
    cell.textLabel.text = str;
    
    return cell;
}

/**
 * テーブルビューのセル押下時
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [bgm_ stop];
    
    // メイン画面を表示する
    MokugyoViewController *viewController = [[MokugyoViewController alloc] initWithNibName:@"MokugyoViewController" bundle:nil];
    viewController.mode = MODE_STAGE;
    viewController.stgId = indexPath.row;
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
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
