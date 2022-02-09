//
//  ClearViewController.h
//  Mokugyo
//
//  Created by 田中郁也 on 2012/11/21.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ClearViewController : UIViewController
{
    AVAudioPlayer       *bgm_;
    
    IBOutlet UIButton       *btnTop_;
    IBOutlet UILabel        *lblMsg_;
    IBOutlet UIImageView    *iv_;
}

-(IBAction)btnTopClick:(id)sender;

@property (nonatomic, assign) NSString *clearId;
@property (nonatomic, assign) NSInteger stgId;

@end
