//
//  DetailViewController.h
//  instagram
//
//  Created by Sj Stroud on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
