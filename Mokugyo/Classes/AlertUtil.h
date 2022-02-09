//
//  AlertUtil.h
//  Mokugyo
//
//  Created by 田中郁也 on 2013/01/15.
//
//

#import <Foundation/Foundation.h>

@interface AlertUtil : NSObject {
    
}

+(UIAlertView*)showDialog:(UIViewController*)uv text:(NSString*)text bttext:(NSString*)bttext leftFlg:(BOOL)leftFlg;

@end
