//
//  ChatTableViewHeader.m
//  supplier
//
//  Created by xiucheren on 16/7/12.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "ChatTableViewHeader.h"
@interface ChatTableViewHeader()
@property (nonatomic,strong)UIView * goodsBackView;
@property (nonatomic,strong)UIImageView * goodsImg;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * priceLabel;


@property (nonatomic,strong)UIView * customerServiceBackView;
@property (nonatomic,strong)UILabel * infoLabel;
@property (nonatomic,copy)SendBlock block;
@end
@implementation ChatTableViewHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


 +(ChatTableViewHeader *)configurationWithGoods:(NSObject *)goods customerService:(NSObject *)customerService block:(SendBlock)block{
    ChatTableViewHeader * header = [[ChatTableViewHeader alloc] init];
    [header configurationGoods:goods];
    [header configurationcustomerService:@""];
     CGFloat height = 0;
     for (UIView * view in header.subviews){
         if (CGRectGetMaxY(view.frame) > height){
             height = CGRectGetMaxY(view.frame);
         }
     }
     header.frame = CGRectMake(0, 0, ScreenSize.width, height + 8);
    return header;
}

-(UIView *)goodsBackView{
    if (!_goodsBackView){
        _goodsBackView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, ScreenSize.width - 16, 16 + 68)];
        _goodsBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_goodsBackView];
        _goodsImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 68, 68)];
        _goodsImg.backgroundColor = [UIColor redColor];
        [_goodsBackView addSubview:_goodsImg];
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_goodsImg.frame) + 8, 8, _goodsBackView.frame.size.width - CGRectGetMaxX(_goodsImg.frame) - 16, 30)];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = BlackColor;
        [_goodsBackView addSubview:_nameLabel];
        
        
    }
    return _goodsBackView;
}
-(UIView *)customerServiceBackView{
    if(!_customerServiceBackView){
        _customerServiceBackView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, ScreenSize.width - 16, 8 + 12 + 8 + 30)];
        [self addSubview:_customerServiceBackView];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, _customerServiceBackView.frame.size.width - 16, 13)];
        label.text = [NSString stringWithFormat:@"系统时间(%@)",[[NSDate date] formattedTime]];
        label.textColor = GrayColor;
        label.font = [UIFont systemFontOfSize:12];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_customerServiceBackView addSubview:label];
        
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 13 + 8 + 8, label.frame.size.width, 14)];
        _infoLabel.textColor = BlackColor;
        _infoLabel.text = @"测试";
        _infoLabel.font = [UIFont systemFontOfSize:13];
        _infoLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_customerServiceBackView addSubview:_infoLabel];
        
    }
    return _customerServiceBackView;
}

-(void)configurationGoods:(NSObject *)goods{
    [self goodsBackView];
    
}
-(void)configurationcustomerService:(NSString *)text{
    [self customerServiceBackView];
    CGRect frame = _customerServiceBackView.frame;
    if (_goodsBackView){
        frame.origin.y = CGRectGetMaxY(_goodsBackView.frame) + 8;
    }
    frame.size.height = CGRectGetMinY(_infoLabel.frame) + 10 + [text boundingRectWithSize:CGSizeMake(_infoLabel.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_infoLabel.font} context:nil].size.height;
    _customerServiceBackView.frame = frame;

 
}
@end
