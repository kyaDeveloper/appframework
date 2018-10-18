

#import <UIKit/UIKit.h>

@interface UIButton (XYButton)

@property(nonatomic ,copy)void(^block)(UIButton*);

-(void)addTapBlock:(void(^)(UIButton*btn))block;

@end
