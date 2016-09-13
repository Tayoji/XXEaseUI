//
//  VerticalButton.m
//  supplier
//
//  Created by xiucheren on 16/7/8.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "VerticalButton.h"

@implementation VerticalButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    [super setTitle:title forState:state];
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, self.bounds.size.width, self.bounds.size.width, self.bounds.size.height - self.bounds.size.width);
}
@end
