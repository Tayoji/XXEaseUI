/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseConversationCell.h"
#import "EMConversation+Noti.h"
#import "EaseMobManager.h"
#import "UIImageView+EMWebCache.h"
#import "MasonryHeader.h"
#import "UIColor+Custom.h"
CGFloat const EaseConversationCellPadding = 10;

@interface EaseConversationCell()

@property (nonatomic) NSLayoutConstraint *titleWithAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *titleWithoutAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *detailWithAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *detailWithoutAvatarLeftConstraint;

@end

@implementation EaseConversationCell

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EaseConversationCell *cell = [self appearance];
    cell.titleLabelColor = [UIColor emBlackColor];
    cell.titleLabelFont = [UIFont systemFontOfSize:15];
    cell.detailLabelColor = [UIColor emGrayColor];
    cell.detailLabelFont = [UIFont systemFontOfSize:15];
    cell.timeLabelColor = [UIColor emGrayColor];
    cell.timeLabelFont = [UIFont systemFontOfSize:14];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showAvatar = YES;
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        [self _setupSubview];
    }
    
    return self;
}

#pragma mark - private layout subviews

- (void)_setupSubview
{
    _avatarView = [[EaseImageView alloc] init];
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    _avatarView.backgroundColor = [UIColor clearColor];
    _avatarView.imageCornerRadius = 5.0;
    [self.contentView addSubview:_avatarView];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timeLabel.font = _timeLabelFont;
    _timeLabel.textColor = _timeLabelColor;
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_timeLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.numberOfLines = 1;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = _titleLabelFont;
    _titleLabel.textColor = _titleLabelColor;
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel.backgroundColor = [UIColor clearColor];
    _detailLabel.font = _detailLabelFont;
    _detailLabel.textColor = _detailLabelColor;
    [self.contentView addSubview:_detailLabel];
    
    [self _setupAvatarViewConstraints];
    [self _setupTitleLabelConstraints];

    [self _setupTimeLabelConstraints];
    [self _setupDetailLabelConstraints];
}

#pragma mark - Setup Constraints

- (void)_setupAvatarViewConstraints
{
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.width.and.height.mas_equalTo(44);

    }];

    
}

- (void)_setupTimeLabelConstraints
{
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(15);
        make.width.mas_greaterThanOrEqualTo(85);
        
    }];
   
}

- (void)_setupTitleLabelConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_top);
        make.left.equalTo(self.avatarView.mas_right).offset(10);
        make.right.equalTo(self.timeLabel.mas_left).offset(0);
        make.height.mas_equalTo(16);
        
    }];

}

- (void)_setupDetailLabelConstraints
{
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarView.mas_bottom);
        make.left.equalTo(self.avatarView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(16);
        
    }];
}

#pragma mark - setter

- (void)setShowAvatar:(BOOL)showAvatar
{
    if (_showAvatar != showAvatar) {
        _showAvatar = showAvatar;
        self.avatarView.hidden = !showAvatar;
    }
}

- (void)setModel:(EMConversation *)model
{
    _model = model;
    
    if ([model.nickname length] > 0) {
        self.titleLabel.text = _model.nickname;
    }
    else{
        self.titleLabel.text = _model.conversationId;
    }
    
    if (self.showAvatar) {
        if ([_model.avatar length] > 0){
            if ([_model.avatar hasPrefix:@"http"]) {
                 [self.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:[[EaseMobManager share] imAvatarImg]];
            }else{
                self.avatarView.imageView.image = [UIImage imageNamed:model.avatar];
            }
        }else{
            self.avatarView.imageView.image = [EaseMobManager share].imAvatarImg;

        }
    }
    
    if (_model.unreadMessagesCount == 0) {
        _avatarView.showBadge = NO;
    }
    else{
        _avatarView.showBadge = YES;
        _avatarView.badge = _model.unreadMessagesCount;
    }
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    _titleLabelFont = titleLabelFont;
    _titleLabel.font = _titleLabelFont;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    _titleLabelColor = titleLabelColor;
    _titleLabel.textColor = _titleLabelColor;
}

- (void)setDetailLabelFont:(UIFont *)detailLabelFont
{
    _detailLabelFont = detailLabelFont;
    _detailLabel.font = _detailLabelFont;
}

- (void)setDetailLabelColor:(UIColor *)detailLabelColor
{
    _detailLabelColor = detailLabelColor;
    _detailLabel.textColor = _detailLabelColor;
}

- (void)setTimeLabelFont:(UIFont *)timeLabelFont
{
    _timeLabelFont = timeLabelFont;
    _timeLabel.font = _timeLabelFont;
}

- (void)setTimeLabelColor:(UIColor *)timeLabelColor
{
    _timeLabelColor = timeLabelColor;
    _timeLabel.textColor = _timeLabelColor;
}

#pragma mark - class method

+ (NSString *)cellIdentifierWithModel:(id)model
{
    return @"EaseConversationCell";
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return EaseConversationCellMinHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (_avatarView.badge) {
        _avatarView.badgeBackgroudColor = [UIColor redColor];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (_avatarView.badge) {
        _avatarView.badgeBackgroudColor = [UIColor redColor];
    }
}

@end
