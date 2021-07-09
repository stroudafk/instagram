//
//  DetailViewController.m
//  instagram
//
//  Created by Sj Stroud on 7/8/21.
//

#import "DetailViewController.h"
#import "Parse/Parse.h"
#import <DateTools.h>
#import "Post.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *imageURL = [NSURL URLWithString:self.post.image.url];
    [self.imageView setImageWithURL:imageURL];
    self.usernameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
