//
//  MokugyoViewController.h
//  Mokugyo
//
//  Created by 陽一 岡本 on 12/10/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>  
#import <QuartzCore/QuartzCore.h>  

@interface MokugyoViewController : UIViewController
{
    NSTimer     *tm_;               // タイマー
    int         time_;              // タイマーの時間
    int         goastLife_;         // お化けのライフ
    int         goastCnt_;          // 倒したお化けの数
    NSInteger   ans_;               // 答えのID
    NSString    *clearId_;          // クリアID
    
    IBOutlet UILabel        *lblCnt_;   // 倒したお化けの数(ラベル)
    IBOutlet UILabel        *lblTime_;  // 残り時間
    IBOutlet UIImageView    *vMain_;    // メインビュー
    IBOutlet UIImageView    *vMoku_;    // 木魚ビュー
    IBOutlet UIImageView    *vKane_;    // ケイスビュー

    UIImageView     *iv_;       // お化けのビュー
    UILabel         *lblLife_;  // お化けのライフ
    
    AVAudioPlayer *bgm_;        // BGM
    SystemSoundID soundMoku_;   // 木魚
    SystemSoundID soundKane_;   // ケイス
    
    UIAlertView   *alert_;      // アラートビュー
}

@property (nonatomic, assign) NSInteger mode;
@property (nonatomic, assign) NSInteger stgId;

@end
