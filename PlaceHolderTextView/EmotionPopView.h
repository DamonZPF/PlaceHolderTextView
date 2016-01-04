//
//  EmotionPopView.h
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/30.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionButton.h"
@interface EmotionPopView : UIView
@property (weak, nonatomic) IBOutlet EmotionButton *emotionButton;

+(instancetype)emotionPopView;

@end
