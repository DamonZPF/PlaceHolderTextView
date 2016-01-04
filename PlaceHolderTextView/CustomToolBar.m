//
//  CustomToolBar.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/23.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "CustomToolBar.h"

@interface CustomToolBar()

-(IBAction)clickButton:(UIButton*)btn;

@end

@implementation CustomToolBar



-(void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;
}

+(instancetype)toolBar{
    return [[[NSBundle mainBundle] loadNibNamed:@"CustomToolBar" owner:nil options:nil] lastObject];
}


-(IBAction)clickButton:(UIButton*)btn{
    btn.selected = !btn.isSelected;
    
    if (self.didClickButton) {
        self.didClickButton();
    }
}

@end
