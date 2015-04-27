//
//  AKPageIndicator.m
//  AKPageIndicator
//
//  Created by Adrian Kemp on 2015-04-27.
//  Copyright (c) 2015 Adrian Kemp
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "AKPageIndicator.h"

@interface AKPageIndicator ()

@property (nonatomic, weak) IBOutlet UIView *backingView;
@property (nonatomic, weak) IBOutlet UIView *highlightView;

@property (nonatomic, weak) UIView *highlightContainerView;

@end

@implementation AKPageIndicator

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (self.backingView == self.highlightView) {} //generate them if missing
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self.backingView == self.highlightView) {} //generate them if missing
    return self;
}

- (void)setHighlightFrame:(CGRect)highlightFrame {
    _highlightFrame = highlightFrame;
    self.highlightContainerView.frame = highlightFrame;
}

- (UIView *)backingView {
    if (!_backingView) {
        UIImage *defaultBackdropImage = [UIImage imageNamed:@"IndicatorBackdrop" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        [self addSubview:_backingView = (UIView *)[[UIImageView alloc] initWithImage:defaultBackdropImage]];
    }
    return _backingView;
}

- (UIView *)highlightView {
    if (!_highlightView) {
        UIImage *defaultHighlightImage = [UIImage imageNamed:@"IndicatorHighlight" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        [self.highlightContainerView addSubview:_highlightView = (UIView *)[[UIImageView alloc] initWithImage:defaultHighlightImage]];
    }
    return _highlightView;
}

- (UIView *)highlightContainerView {
    if (!_highlightContainerView) {
        CGRect highlightFrame = (CGRectIsNull(self.highlightFrame) ? self.highlightFrame : CGRectMake(0, 0, 20, 20));
        [self addSubview:_highlightContainerView = (UIView *)[[UIView alloc] initWithFrame:highlightFrame]];
        _highlightContainerView.clipsToBounds = YES;
    }
    return _highlightContainerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollingProgress = scrollView.contentOffset.x / scrollView.contentSize.width;
    
    CGFloat xOffset = (self.backingView.bounds.size.width - self.highlightContainerView.bounds.size.width/2) * scrollingProgress;
    self.highlightContainerView.transform = CGAffineTransformMakeTranslation(xOffset, 0.0f);
    self.highlightView.transform = CGAffineTransformMakeTranslation(-xOffset, 0.0f);
}

@end
