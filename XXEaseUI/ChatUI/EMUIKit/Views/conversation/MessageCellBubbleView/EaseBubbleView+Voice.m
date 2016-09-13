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

#import "EaseBubbleView+Voice.h"
#import "EaseBaseMessageCell.h"
#define ISREAD_VIEW_SIZE 10.f

@implementation EaseBubbleView (Voice)

#pragma mark - private

- (void)_setupVoiceBubbleMarginConstraints
{
    [self.marginConstraints removeAllObjects];
    UIView * superView = self.superview;
    while (![superView isKindOfClass:[EaseBaseMessageCell class]]) {
        superView = superView.superview;
    }
    //image view
    NSLayoutConstraint *imageWithMarginTopConstraint = [NSLayoutConstraint constraintWithItem:self.voiceImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top];
    NSLayoutConstraint *imageWithMarginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.voiceImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
    [self.marginConstraints addObject:imageWithMarginTopConstraint];
    [self.marginConstraints addObject:imageWithMarginBottomConstraint];

    //duration label
    NSLayoutConstraint *durationWithMarginTopConstraint = [NSLayoutConstraint constraintWithItem:self.voiceDurationLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top];
    NSLayoutConstraint *durationWithMarginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.voiceDurationLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
    [self.marginConstraints addObject:durationWithMarginTopConstraint];
    [self.marginConstraints addObject:durationWithMarginBottomConstraint];
//    EaseBaseMessageCell * cell = (EaseBaseMessageCell *)superView;
//    CGFloat mu = ([cell.model mediaDuration] > 5 ? 5 : [cell.model mediaDuration])/5 * 100;
    if(self.isSender){
        NSLayoutConstraint *imageWithMarginRightConstraint = [NSLayoutConstraint constraintWithItem:self.voiceImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
        [self.marginConstraints addObject:imageWithMarginRightConstraint];

//        NSLayoutConstraint *imageWithMarginLeftContraint = [NSLayoutConstraint constraintWithItem:self.voiceImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:_margin.left + mu];
//        [self.marginConstraints addObject:imageWithMarginLeftContraint];
        
        
        NSLayoutConstraint *durationRightConstraint = [NSLayoutConstraint constraintWithItem:self.voiceDurationLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding];
        [self.marginConstraints addObject:durationRightConstraint];
        

    }
    else{
        NSLayoutConstraint *imageWithMarginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.voiceImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
        [self.marginConstraints addObject:imageWithMarginLeftConstraint];
        
        NSLayoutConstraint *durationLeftConstraint = [NSLayoutConstraint constraintWithItem:self.voiceDurationLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseMessageCellPadding];
        [self.marginConstraints addObject:durationLeftConstraint];
        
      
           [self.marginConstraints addObject:[NSLayoutConstraint constraintWithItem:self.isReadView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.voiceDurationLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:ISREAD_VIEW_SIZE/2]];
        [self.marginConstraints addObject:[NSLayoutConstraint constraintWithItem:self.isReadView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        [self.marginConstraints addObject:[NSLayoutConstraint constraintWithItem:self.isReadView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:ISREAD_VIEW_SIZE]];
        
        [self.marginConstraints addObject:[NSLayoutConstraint constraintWithItem:self.isReadView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:ISREAD_VIEW_SIZE]];
    }
    
    [self addConstraints:self.marginConstraints];
}

- (void)_setupVoiceBubbleConstraints
{
    if (self.isSender) {
        self.isReadView.hidden = YES;
    }
    [self _setupVoiceBubbleMarginConstraints];
}

#pragma mark - public

- (void)setupVoiceBubbleView
{
    self.voiceImageView = [[UIImageView alloc] init];
    self.voiceImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.voiceImageView.backgroundColor = [UIColor clearColor];
    self.voiceImageView.animationDuration = 1;
    [self.backgroundImageView addSubview:self.voiceImageView];
    
    self.voiceDurationLabel = [[UILabel alloc] init];
    self.voiceDurationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.voiceDurationLabel.backgroundColor = [UIColor clearColor];
    [self.backgroundImageView addSubview:self.voiceDurationLabel];
    
    self.isReadView = [[UIImageView alloc] init];
    self.isReadView.translatesAutoresizingMaskIntoConstraints = NO;
    self.isReadView.layer.cornerRadius = ISREAD_VIEW_SIZE/2;
    self.isReadView.clipsToBounds = YES;
    self.isReadView.backgroundColor = [UIColor redColor];
    [self.backgroundImageView addSubview:self.isReadView];
    
    [self _setupVoiceBubbleConstraints];
}

- (void)updateVoiceMargin:(UIEdgeInsets)margin
{
    if (_margin.top == margin.top && _margin.bottom == margin.bottom && _margin.left == margin.left && _margin.right == margin.right) {
        return;
    }
    _margin = margin;
    
    [self removeConstraints:self.marginConstraints];
    [self _setupVoiceBubbleMarginConstraints];
}

-(void)updateBackGroundImgWidth:(CGFloat)width;
{
    [self.marginConstraints removeObject:self.backGrounpImgWidthConstraint];
    self.backGrounpImgWidthConstraint = [NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
}
@end
