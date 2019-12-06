//
//  NUTableViewCell.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NUTableViewCell.h"

@implementation NUCellData

- (CGFloat)heightOfWidth:(CGFloat)width {
    return 44;
}
@end
@interface NUTableViewCell ()
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong, readwrite) NUCellData *data;
@end
@implementation NUTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        _tapRecognizer.delegate = self;
        _tapRecognizer.cancelsTouchesInView = NO;

        _colorWhenTouched = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0  blue:219.0/255.0  alpha:1];
        _changeColorWhenTouched = NO;
        self.backgroundColor = [UIColor whiteColor];
		self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)tapGesture:(UIGestureRecognizer *)gesture {
    if (self.data.ctarget && self.data.cselector) {
        if ([self.data.ctarget respondsToSelector:self.data.cselector]) {
            self.selected = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.data.ctarget performSelector:self.data.cselector withObject:self];
#pragma clang diagnostic pop
        }
    }
}

#pragma mark - public
- (void)fillWithData:(NUCellData *)data {
    self.data = data;
    if (data.cselector) {
        [self addGestureRecognizer:self.tapRecognizer];
    } else {
        [self removeGestureRecognizer:self.tapRecognizer];
    }
	
	/*
	 @weakify(self)
		[[[RACObserve(convData, title) takeUntil:self.rac_prepareForReuseSignal]
		  distinctUntilChanged] subscribeNext:^(NSString *x) {
			@strongify(self)
			self.titleLabel.text = x;
		}];
		[[RACObserve(convData, avatarUrl) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSURL *x) {
			@strongify(self)
			if (self.convData.convType == TIM_GROUP) { //群组
				UIImage *avatar = [self getCacheGroupAvatar];
				if (avatar != nil) { //已缓存群组头像
					self.headImageView.image = avatar;
				} else { //未缓存群组头像
					[self.headImageView sd_setImageWithURL:x
										  placeholderImage:self.convData.avatarImage];
					[self prefetchGroupMembers];
				}
			} else {//个人头像
				[self.headImageView sd_setImageWithURL:x
									  placeholderImage:self.convData.avatarImage];
			}
		}];
	 
	 */
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.changeColorWhenTouched){
        self.backgroundColor = self.colorWhenTouched;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.changeColorWhenTouched){
        self.backgroundColor = [UIColor whiteColor];
		self.contentView.backgroundColor = [UIColor whiteColor];
    }
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.changeColorWhenTouched){
        self.backgroundColor = [UIColor whiteColor];
		self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.changeColorWhenTouched){
        self.backgroundColor = [UIColor whiteColor];
		self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
