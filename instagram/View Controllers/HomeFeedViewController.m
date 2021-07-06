//
//  HomeFeedViewController.m
//  instagram
//
//  Created by Sj Stroud on 7/6/21.
//

#import "HomeFeedViewController.h"

@interface HomeFeedViewController ()

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
 
 
 /*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.

     if([segue.identifier isEqual:@"TweetSegue"]){
         UINavigationController *navigationController = [segue destinationViewController];
         ComposeViewController *composeController = (ComposeViewController *)navigationController.topViewController;
         composeController.delegate = self;
     }
     else if([segue.identifier isEqual:@"TweetDetailSegue"]){
         UITableViewCell *tappedCell = sender;
         NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
         
         UINavigationController *navigationController = [segue destinationViewController];
         Tweet *tweetDetails = self.tweets[indexPath.row];
         //DetailsViewController *detailsViewController = (DetailsViewController *)navigationController.topViewController;
         DetailsViewController *detailsViewController = (DetailsViewController *)navigationController.childViewControllers.firstObject;
         detailsViewController.tweet = tweetDetails;
     }
 }

*/

@end
