//
//  MokugyoViewController.m
//  Mokugyo
//
//  Created by 陽一 岡本 on 12/10/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MokugyoViewController.h"
#import "RankViewController.h"
#import "ClearViewController.h"
#import "AlertUtil.h"

@implementation MokugyoViewController
@synthesize mode, stgId;

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *msg = [self getStartmsg];
    alert_ = [AlertUtil showDialog:self text:msg bttext:@"開始" leftFlg:YES];
}

/**
 * インスタンス解放時
 */
- (void)dealloc
{
    [super dealloc];
    [lblCnt_ release];
    [lblTime_ release];
    [vMain_ release];
    [vMoku_ release];
    [vKane_ release];
    [iv_ release];
    [lblLife_ release];
    [bgm_ release];
    //[tm_ release];
    //[clearId_ release];
    //[alert_ release];
}

/**
 * ゲーム開始
 */
- (void)gameStart
{
    // 制限時間
    time_ = [self getLimitTime];
    // 倒した数
    goastCnt_ = 0;
    // BGM設定
    [self setBgm];
    // タイマー設定
    [self setTimer];
    // お化け生成
    [self addGhost];
}

/**
 * BGMを設定する
 */
- (void)setBgm
{
    // BGM
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dadan" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    bgm_ = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];  
    bgm_.enableRate = YES;
    bgm_.numberOfLoops = -1;
    [bgm_ play];

    // 木魚
    path = [[NSBundle mainBundle] pathForResource:@"moku" ofType:@"mp3"];
    url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &soundMoku_);

    // ケイス
    path = [[NSBundle mainBundle] pathForResource:@"rin" ofType:@"wav"];
    url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &soundKane_);
}

/**
 * タイマーの設定
 */
-(void)setTimer
{
    // 1秒毎に処理がはしる
    tm_ = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                          target:self
                                        selector:@selector(cntTimer:)
                                        userInfo:nil
                                         repeats:YES];
}

/**
 * ゲーム終了のタイマー
 */
- (void)endTimer
{
    // 3秒毎に処理がはしる
    tm_ = [NSTimer scheduledTimerWithTimeInterval:2.0f
                                           target:self
                                         selector:@selector(gameEnd:)
                                         userInfo:nil
                                          repeats:YES];
}

/**
 * タイマー処理
 */
-(void)cntTimer:(NSTimer*)timer
{
    // タイム減少
    time_ -= 1;

    // ラベルに設定
    lblTime_.text = [NSString stringWithFormat:@"%d", time_];

    // 0秒になった場合
    if (time_ < 1){
        // 失敗時処理
        [self goastNg];
    }
}

/**
 * 制限時間取得
 */
-(int)getLimitTime
{
    int time = 0;
    switch (stgId) {
        case STAGE_10:
            time = 30;
            break;
        case STAGE_11:
            time = 50;
            break;
        case STAGE_12:
            time = 100;
            break;
        default:
            time = 2;
            break;
    }
    
    return time;
}

/**
 * お化けの生成
 */
-(void)addGhost
{
    // ランダムにx, yの位置取得
    NSInteger r = [self getRandInt:0 max:220];
    NSInteger h = [self getRandInt:100 max:250];
    
    // ランダムにお化けの回答生成
    ans_ = [self getRandInt:0 max:1];
    switch(ans_){
        case 0:
            // 白いお化け生成
            iv_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
            iv_.image = [UIImage imageNamed:@"obake_white.png"];
            break;
        case 1:
            // 黄色いお化け生成
            iv_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
            iv_.image = [UIImage imageNamed:@"obake_yellow.png"];
            break;
    }

    // おばけのライフ
    int s = 0;
    if (stgId == STAGE_4 || stgId == STAGE_5 || stgId == STAGE_6 || stgId == STAGE_1000) {
        // ライフ1モード
        s = 1;
    } else {
        // その他はランダムで
        s = [self getRandInt:1 max:3];
    }
    goastLife_ = s;

    // お化け表示
    iv_.frame = CGRectMake(r, h, 100, 150);
    [self fadeInWithDuration:iv_];
    [vMain_ addSubview:iv_];

    // ライフのラベル
    lblLife_ = [[UILabel alloc] init];
    lblLife_.frame = CGRectMake(45, 70, 45, 40);
    lblLife_.backgroundColor = [UIColor clearColor];
    lblLife_.textColor = [UIColor redColor];
    lblLife_.font = [UIFont fontWithName:@"DBLCDTempBlack" size:30];
    lblLife_.text = [NSString stringWithFormat:@"%d", goastLife_];
    [iv_ addSubview:lblLife_];
    
    if (stgId == STAGE_7 || stgId == STAGE_8 || stgId == STAGE_9) {
        [self fadeOutLabel:(UILabel *)lblLife_];
        lblLife_ = nil;
    }
}

/**
 * 乱数取得
 */
-(int)getRandInt:(int)min max:(int)max
{
	static int randInitFlag;
	if (randInitFlag == 0) {
		srand((int)time(NULL));
		randInitFlag = 1;
	}
	return min + (int)(rand()*(max-min+1.0)/(1.0+RAND_MAX));
}

/**
 * デバイスタップ時
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // ゲームが終了していた場合
    if ([clearId_ isEqual:STAGE_CLEAR] || [clearId_ isEqual:STAGE_MISS]) {
        return;
    }
    
    // タッチ座標を取得
    CGPoint point = [((UITouch*)[touches anyObject])locationInView:self.view];
   
    NSInteger ans;
    
    if (CGRectContainsPoint(vMoku_.frame, point)) {
        // 木魚タップ時
        ans = 0;
        AudioServicesPlaySystemSound(soundMoku_);
    } else if (CGRectContainsPoint(vKane_.frame, point)) {
        // ケイスタップ時
        ans = 1;
        AudioServicesPlaySystemSound(soundKane_);
    } else {
        return;
    }
    
    // 正解チェック
    if (ans == ans_) {
        // 正解処理
        [self goastOk];
    } else {
        // 不正解処理
        [self goastNg];
    }
}

/**
 * 正解
 */
- (void)goastOk
{
    // ライフを削る
    goastLife_--;
    lblLife_.text = [NSString stringWithFormat:@"%d", goastLife_];

    // ライフまだあったらリターン
    if (goastLife_ > 0) {
        return;
    }
    
    // 倒した数
    goastCnt_++;
    lblCnt_.text = [NSString stringWithFormat:@"%d", goastCnt_];
    
    // お化け消す
    [self fadeOutWithDuration:(UIImageView *)iv_ :YES];
    iv_ = nil;
    
    // クリアかどうか
    if (mode == MODE_STAGE && [self getStageClear]) {

        // ストップ
        [tm_ invalidate];
        [bgm_ stop];
        
        // ゲーム終了
        clearId_ = STAGE_CLEAR;
        [self endTimer];
        
    } else {
        // お化け生成
        [self addGhost];
        
        if (stgId != STAGE_10 && stgId != STAGE_11 && stgId != STAGE_12) {
            // タイマー再設定
            time_ = [self getLimitTime];
            [tm_ invalidate];
            lblTime_.text = [NSString stringWithFormat:@"%d", time_];
            [self setTimer];
        }
    }
}

/**
 * 失敗
 */
- (void)goastNg
{
    // ストップ
    [tm_ invalidate];
    [bgm_ stop];

    // お化け消す
    [self fadeOutWithDuration:(UIImageView *)iv_ :NO];
    iv_ = nil;
    
    // こわいおばけ
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    iv.image = [UIImage imageNamed:@"jobutsu_obake_white.png"];
    iv.frame = CGRectMake(30, 70, 260, 370);
    [self fadeInWithDuration:iv];
    [vMain_ addSubview:iv];
    
    // 終了ラベル
    UILabel *lbl = [[UILabel alloc] init];
    lbl.frame = CGRectMake(95, 80, 100, 40);
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor blueColor];
    lbl.font = [UIFont fontWithName:@"DBLCDTempBlack" size:30];
    lbl.text = @"ミス！";
    [iv addSubview:lbl];
    
    // ゲーム終了
    clearId_ = STAGE_MISS;
    [self endTimer];
}

/**
 * アラートのボタン押下時
 */
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // アラート消す
    [alert_ dismissWithClickedButtonIndex:0 animated:NO];
    
    if (clearId_ == nil || [clearId_ isEqualToString:@""]){
        // ゲーム開始
        [self gameStart];
    }
}

/**
 * ステージクリアしたかどうか
 * [ステージ変更時修正箇所]
 */
- (bool)getStageClear
{
    bool clearFlg = false;
    
    if ((stgId == STAGE_1 || stgId == STAGE_4 || stgId == STAGE_7 || stgId == STAGE_10) && goastCnt_ >= 30) {
        clearFlg = true;
    } else if((stgId == STAGE_2 || stgId == STAGE_5 || stgId == STAGE_8 || stgId == STAGE_11) && goastCnt_ >= 50) {
        clearFlg = true;
    } else if((stgId == STAGE_3 || stgId == STAGE_6 || stgId == STAGE_9 || stgId == STAGE_12) && goastCnt_ >= 100) {
        clearFlg = true;
    }

    return clearFlg;
}

/**
 * ゲーム終了時
 */
-(void)gameEnd:(NSTimer*)timer
{
    // ストップ
    [tm_ invalidate];    
    
    if (mode == MODE_STAGE) {
        // クリア画面を表示する
        ClearViewController *viewController = [[ClearViewController alloc] initWithNibName:@"ClearViewController" bundle:nil];
        viewController.clearId = clearId_;
        viewController.stgId = stgId;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    } else {
        // ランキング画面を表示する
        RankViewController *viewController = [[RankViewController alloc] initWithNibName:@"RankViewController" bundle:nil];
        viewController.cnt = goastCnt_;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
}

/**
 * 開始メッセージを取得する
 * [ステージ変更時修正箇所]
 */
-(NSString *)getStartmsg {
    NSString *msg = @"白いおばけは木魚、黄色いおばけはケイスで倒せ！\n\n間違えたり、時間以内に倒せなければゲームオーバー！\n\n";
    NSString *addmsg = @"";
    
    switch(stgId){
    case STAGE_1:
        addmsg = @"30匹倒したらクリア！";
        break;
    case STAGE_2:
        addmsg = @"50匹倒したらクリア！";
        break;
    case STAGE_3:
        addmsg = @"100匹倒したらクリア！";
        break;
    case STAGE_4:
        addmsg = @"おばけのライフは全て1だ！\n\n30匹倒したらクリア！";
        break;
    case STAGE_5:
        addmsg = @"おばけのライフは全て1だ！\n\n50匹倒したらクリア！";
        break;
    case STAGE_6:
        addmsg = @"おばけのライフは全て1だ！\n\n100匹倒したらクリア！";
        break;
    case STAGE_7:
        addmsg = @"おばけのライフが見えなくなってしまうぞ！\n\n30匹倒したらクリア！";
        break;
    case STAGE_8:
        addmsg = @"おばけのライフが見えなくなってしまうぞ！\n\n50匹倒したらクリア！";
        break;
    case STAGE_9:
        addmsg = @"おばけのライフが見えなくなってしまうぞ！\n\n100匹倒したらクリア！";
        break;
    case STAGE_10:
        addmsg = @"30秒以内に30匹倒したらクリア！";
        break;
    case STAGE_11:
        addmsg = @"50秒以内に50匹倒したらクリア！";
        break;
    case STAGE_12:
        addmsg = @"100秒以内に100匹倒したらクリア！";
        break;
    case STAGE_1000:
    addmsg = @"おばけのライフは全て1だ！";
        break;
    default:
        break;
    }

    msg = [NSString stringWithFormat:@"%@%@",msg,addmsg];
    
    return msg;
}

/**
 * ImageViewのフェードイン
 */
- (void)fadeInWithDuration:(UIImageView *)iv
{
	CGFloat afterAlpha = iv.alpha;
	iv.alpha = (CGFloat)0.0;
	iv.hidden = NO;
	[UIView beginAnimations:@"UIWindow_FadeIn" context:nil];
	[UIView setAnimationDuration:0.5];
	iv.alpha = afterAlpha;
	[UIView commitAnimations];
}

/**
 * ImageViewのフェードアウト
 */
- (void)fadeOutWithDuration:(UIImageView *)iv :(BOOL)roll
{
    if (roll) {
        // 回転アニメーション
        iv.transform = CGAffineTransformMakeRotation(0);
        [UIView animateWithDuration:0.2
                         animations:^{
                             iv.transform =
                             CGAffineTransformMakeRotation(2*M_PI*180/360.0-0.000001);
                         }];
    }

    // フェードアウトアニメーション    
	CGFloat* context = (CGFloat *)malloc(sizeof(CGFloat));
	*context = iv.alpha;
	[UIView beginAnimations:@"UIWindow_FadeOut" context:context];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	iv.alpha = (CGFloat)0.0;
	[UIView commitAnimations];
}

/**
 * Labelのフェードアウト
 */
- (void)fadeOutLabel:(UILabel *)lbl
{
    // フェードアウトアニメーション
	CGFloat* context = (CGFloat *)malloc(sizeof(CGFloat));
	*context = lbl.alpha;
	[UIView beginAnimations:@"UIWindow_FadeOut" context:context];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1.0];
	lbl.alpha = (CGFloat)0.0;
	[UIView commitAnimations];
}

@end
