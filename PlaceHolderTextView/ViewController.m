//
//  ViewController.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/19.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "ViewController.h"
#import "PlaceholderTextView.h"
#import "CustomToolBar.h"
#import "EmotionKeyboardView.h"
#import "EmotionModel.h"
#import "NSString+Emoji.h"
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)  CustomToolBar * tooBar;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property(strong,nonatomic)EmotionKeyboardView * keyboardView;
@end

@implementation ViewController

-(EmotionKeyboardView*)keyboardView{

    if (_keyboardView == nil) {
        
        _keyboardView = [EmotionKeyboardView emotionKeyboardView];
    }
    
    return _keyboardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.textView.alwaysBounceVertical = YES;
  
    
    CustomToolBar * tooBar = [CustomToolBar toolBar];
    tooBar.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    [self.view addSubview:tooBar];
    tooBar.didClickButton = ^(){
    
        [self switchBoard]; //切换键盘
        
    };
    self.tooBar = tooBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getEmotionModel:) name:@"EmotionNameModelKey" object:nil];
}


-(void)getEmotionModel:(NSNotification*)note{
    NSDictionary * dict = note.userInfo;
    EmotionModel * emotionModel = dict[@"EmotionNameModelKey"];
    
    if (emotionModel.code) {
        [self.textView insertText:emotionModel.code.emoji];
    }else if(emotionModel.png){
        UIImage * image  = [UIImage imageNamed:emotionModel.png];
        NSMutableAttributedString * mutiAttributedString = [[NSMutableAttributedString alloc]init];
        [mutiAttributedString appendAttributedString:self.textView.attributedText]; //保存原来已有的文字及属性
        
        NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        attachment.bounds = CGRectMake(0, -4, self.textView.font.lineHeight, self.textView.font.lineHeight);
        NSAttributedString * attributedString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSInteger location = self.textView.selectedRange.location;
        
        [mutiAttributedString insertAttributedString:attributedString atIndex:location];
        
        [mutiAttributedString addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, mutiAttributedString.length)];
        
        self.textView.attributedText = mutiAttributedString;
        
        self.textView.selectedRange = NSMakeRange(location + 1, 0);
        
        NSLog(@"____%@__%@",emotionModel.chs,emotionModel.code);
    }
   
}

-(void)switchBoard{
    
    if (self.textView.inputView == nil) {
        self.textView.inputView =self.keyboardView;
    }else{
        self.textView.inputView = nil;
    }
    
    [self.textView resignFirstResponder];
     __weak typeof(self) weakSlef = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [weakSlef.textView becomeFirstResponder];
    });
    
}


-(void)keyboardShow:(NSNotification*)note{

    CGFloat animationDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyBoardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
      self.tooBar.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height - keyBoardFrame.size.height - 44, self.view.frame.size.width, 44);
    }];
}

-(void)keyboardHide:(NSNotification*)note{
    CGFloat animationDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
       [UIView animateWithDuration:animationDuration animations:^{
        self.tooBar.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height  - 44, self.view.frame.size.width, 44);
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textView resignFirstResponder];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
