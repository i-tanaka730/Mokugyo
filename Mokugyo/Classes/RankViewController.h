//
//  RankViewController.h
//  Mokugyo
//
//  Created by 陽一 岡本 on 12/10/31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RankViewController : UIViewController
{
    AVAudioPlayer       *bgm_;
    
    IBOutlet UIButton *btnTop_;
    IBOutlet UILabel *lbl1_;
    IBOutlet UILabel *lbl2_;
    IBOutlet UILabel *lbl3_;
}

-(IBAction)btnTopClick:(id)sender;

@property (nonatomic, assign) int cnt;

@end
