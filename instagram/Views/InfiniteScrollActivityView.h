//
//  InfiniteScrollActivityView.h
//  instagram
//
//  Created by Sj Stroud on 7/9/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface InfiniteScrollActivityView : UIView

@property (class, nonatomic, readonly) CGFloat defaultHeight;

- (void)startAnimating;
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
