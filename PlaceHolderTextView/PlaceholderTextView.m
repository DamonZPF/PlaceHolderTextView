//
//  PlaceholderTextView.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/19.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "PlaceholderTextView.h"

@implementation PlaceholderTextView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

-(void)awakeFromNib{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textChange{

    [self setNeedsDisplay];
    
}

-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    
    [self setNeedsDisplay];
}

-(void)setPlaceHolderString:(NSString *)placeHolderString{
    _placeHolderString = [placeHolderString copy];
    
    [self setNeedsDisplay];
    
}

-(void)setFont:(UIFont *)font{
    
    [super setFont:font];
    
    [self setNeedsDisplay];
    
}

-(void)setText:(NSString *)text{
    [super setText:text];
    
    [self setNeedsDisplay]; //会在下一个消息循环 调用drawRect
}

-(void)drawRect:(CGRect)rect{
    if (self.hasText) {
        return;
    }
    
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = self.font;
    attributes[NSForegroundColorAttributeName] = self.placeHolderColor ? self.placeHolderColor : [UIColor lightGrayColor];
    
    CGFloat  x = 5;
    CGFloat  y = 8;
    CGFloat width = rect.size.width - 2*x;
    CGFloat heigth = rect.size.height - 2*y;
    CGRect placeholderRect = CGRectMake(x, y, width, heigth);
    [self.placeHolderString drawInRect:placeholderRect withAttributes:attributes];
}

@end
