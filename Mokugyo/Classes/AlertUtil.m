//
//  AlertUtil.m
//  Mokugyo
//
//  Created by 田中郁也 on 2013/01/15.
//
//

#import "AlertUtil.h"

@implementation AlertUtil

+(UIAlertView*)showDialog:(UIViewController*)uv text:(NSString*)text bttext:(NSString*)bttext leftFlg:(BOOL)leftFlg
{
    // ダイアログの表示
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@""
                                                    message:text
                                                   delegate:uv
                                          cancelButtonTitle:nil
                                          otherButtonTitles:bttext
                           ,nil]autorelease];

    if((leftFlg) && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)  {  //iOS7未満の場合
        ((UILabel *)[[alert subviews] objectAtIndex:1]).textAlignment = NSTextAlignmentLeft;
    }
    
    [alert show];
    
//    // アラート背景の設定
//    UIImageView *bgImg = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dlgback.jpg"]]autorelease];
//    [bgImg setFrame:CGRectMake(0, 0, 300, 120)];
//    [alert addSubview:bgImg];
//    
//    // ラベルの設定
//    UILabel *label = [[UILabel alloc] init];
//    label.numberOfLines = 2;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.frame = CGRectMake(30, 5, 250, 50);
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor blueColor];
//    label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
//    label.text = text;
//    [alert addSubview:label];
//    
//    // ボタンの設定
//    UIImage *img = [UIImage imageNamed:@"alert_btn.jpg"];
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
//    [btn setBackgroundImage:img forState:UIControlStateNormal];
//    [btn addTarget:uv action:@selector(btnAlertClick:) forControlEvents:UIControlEventTouchUpInside];
//    [alert addSubview:btn];
//    
//    // ボタンラベルの設定
//    UILabel *label2 = [[UILabel alloc] init];
//    label2.frame = CGRectMake(75, 0, 70, 50);
//    label2.backgroundColor = [UIColor clearColor];
//    label2.textColor = [UIColor whiteColor];
//    label2.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
//    label2.text = bttext;
//    [btn addSubview:label2];
    
    return alert;
}

@end
