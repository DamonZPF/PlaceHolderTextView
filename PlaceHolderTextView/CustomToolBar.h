//
//  CustomToolBar.h
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/23.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomToolBar : UIView
@property(copy,nonatomic)void (^didClickButton)();
+(instancetype)toolBar;

@end
