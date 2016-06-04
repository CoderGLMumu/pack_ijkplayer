//
//  ZFBrightnessView.m
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ZFBrightnessView.h"
//#import "ZFPlayer.h"

// 屏幕的宽
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕的高
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ZFBrightnessView ()

@property (nonatomic, strong) UIImageView		*backImage;
@property (nonatomic, strong) UILabel			*title;
@property (nonatomic, strong) UIView			*longView;
@property (nonatomic, strong) NSMutableArray	*tipArray;
@property (nonatomic, assign) BOOL				orientationDidChange;
@property (nonatomic, strong) NSTimer			*timer;

@end

@implementation ZFBrightnessView

+ (instancetype)sharedBrightnessView {
	static ZFBrightnessView *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[ZFBrightnessView alloc] init];
		[[UIApplication sharedApplication].keyWindow addSubview:instance];
	});
	return instance;
}

- (instancetype)init {
	if (self = [super init]) {
		self.frame = CGRectMake(ScreenWidth * 0.5, ScreenHeight * 0.5, 155, 155);
		
        self.layer.cornerRadius  = 10;
        self.layer.masksToBounds = YES;
        
        // 使用UIToolbar实现毛玻璃效果，简单粗暴，支持iOS7+
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
        toolbar.alpha = 0.97;
        [self addSubview:toolbar];
        
		self.backImage = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 79, 76)];
            imgView.image        = [UIImage imageNamed:@"playgesture_BrightnessSun6"];
			[self addSubview:imgView];
			imgView;
		});
		
		self.title = ({
            UILabel *title      = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.bounds.size.width, 30)];
            title.font          = [UIFont boldSystemFontOfSize:16];
            title.textColor     = [UIColor colorWithRed:0.25f green:0.22f blue:0.21f alpha:1.00f];
            title.textAlignment = NSTextAlignmentCenter;
            title.text          = @"亮度";
			[self addSubview:title];
			title;
		});
		
		self.longView = ({
            UIView *longView         = [[UIView alloc]initWithFrame:CGRectMake(13, 132, self.bounds.size.width - 26, 7)];
            longView.backgroundColor = [UIColor colorWithRed:0.25f green:0.22f blue:0.21f alpha:1.00f];
			[self addSubview:longView];
			longView;
		});
		
		[self createTips];
		[self addNotification];
		[self addObserver];
		
		self.alpha = 0.0;
	}
	return self;
}

// 创建 Tips
- (void)createTips {
	
	self.tipArray = [NSMutableArray arrayWithCapacity:16];
	
	CGFloat tipW = (self.longView.bounds.size.width - 17) / 16;
	CGFloat tipH = 5;
	CGFloat tipY = 1;
	
	for (int i = 0; i < 16; i++) {
        CGFloat tipX          = i * (tipW + 1) + 1;
        UIImageView *image    = [[UIImageView alloc] init];
        image.backgroundColor = [UIColor whiteColor];
        image.frame           = CGRectMake(tipX, tipY, tipW, tipH);
		[self.longView addSubview:image];
		[self.tipArray addObject:image];
	}
	[self updateLongView:[UIScreen mainScreen].brightness];
}

#pragma makr - 通知 KVO
- (void)addNotification {
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(updateLayer:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
}

- (void)addObserver {
	
	[[UIScreen mainScreen] addObserver:self
							forKeyPath:@"brightness"
							   options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
						change:(NSDictionary *)change
					   context:(void *)context {
	
	CGFloat sound = [change[@"new"] floatValue];
	[self appearSoundView];
	[self updateLongView:sound];
}

- (void)updateLayer:(NSNotification *)notify {
	self.orientationDidChange = YES;
	[self setNeedsLayout];
}

#pragma mark - Methond
- (void)appearSoundView {
	if (self.alpha == 0.0) {
		self.alpha = 1.0;
		[self updateTimer];
	}
}

- (void)disAppearSoundView {
	
	if (self.alpha == 1.0) {
		[UIView animateWithDuration:0.8 animations:^{
			self.alpha = 0.0;
		} completion:^(BOOL finished) {
			
		}];
	}
}

#pragma mark - Timer Methond
- (void)addtimer {
	
	if (self.timer) {
		return;
	}
	
	self.timer = [NSTimer timerWithTimeInterval:3
										 target:self
									   selector:@selector(disAppearSoundView)
									   userInfo:nil
										repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)removeTimer {
	
	if (self.timer) {
		[self.timer invalidate];
		self.timer = nil;
	}
}

- (void)updateTimer {
	[self removeTimer];
	[self addtimer];
}

#pragma mark - Update View
- (void)updateLongView:(CGFloat)sound {
	CGFloat stage = 1 / 15.0;
	NSInteger level = sound / stage;
	
	for (int i = 0; i < self.tipArray.count; i++) {
		UIImageView *img = self.tipArray[i];
		
		if (i <= level) {
			img.hidden = NO;
		} else {
			img.hidden = YES;
		}
	}
}

- (void)didMoveToSuperview {}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	[self setNeedsLayout];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	if (self.orientationDidChange) {
		[UIView animateWithDuration:0.25 animations:^{
			if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait
				|| [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp) {
				self.center = CGPointMake(ScreenWidth * 0.5, (ScreenHeight - 10) * 0.5);
			} else {
				self.center = CGPointMake(ScreenWidth * 0.5, ScreenHeight * 0.5);
			}
		} completion:^(BOOL finished) {
			self.orientationDidChange = NO;
		}];
	} else {
		if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
			self.center = CGPointMake(ScreenWidth * 0.5, (ScreenHeight - 10) * 0.5);
		} else {
			self.center = CGPointMake(ScreenWidth * 0.5, ScreenHeight * 0.5);
		}
	}
	
	self.backImage.center = CGPointMake(155 * 0.5, 155 * 0.5);
}

- (void)dealloc {
	[[UIScreen mainScreen] removeObserver:self forKeyPath:@"brightness"];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end