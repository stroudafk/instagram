//
//  HomeFeedViewController.m
//  instagram
//
//  Created by Sj Stroud on 7/6/21.
//

#import "HomeFeedViewController.h"
#import "Parse/Parse.h"

@interface HomeFeedViewController ()
- (IBAction)didTapLogout:(id)sender;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
