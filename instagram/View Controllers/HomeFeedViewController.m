//
//  HomeFeedViewController.m
//  instagram
//
//  Created by Sj Stroud on 7/6/21.
//

#import "HomeFeedViewController.h"
#import "Parse/Parse.h"
#import "PostCell.h"
#import "Post.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"
#import "InfiniteScrollActivityView.h"
#import <DateTools.h>
#import "SceneDelegate.h"

@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
- (IBAction)didTapLogout:(id)sender;
- (IBAction)didTapNewPost:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (strong, nonatomic) InfiniteScrollActivityView *loadingMoreView;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchPosts];
    // Do any additional setup after loading the view.
    [self.tableView reloadData];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

-(void)loadMoreData{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    query.skip = self.posts.count;
    
    
    
    // Configure query so that completion handler is executed on main UI thread
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError * error) {
        if (posts) {
            
            // Update flag
            self.isMoreDataLoading = false;
            
            // Stop the loading indicator
            [self.loadingMoreView stopAnimating];

            // ... Use the new data to update the data source ...
            [self.posts arrayByAddingObjectsFromArray:posts];
            
            // Reload the tableView now that there is new data
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }

        [self.refreshControl endRefreshing];
    }];
    
    // Set up Infinite Scroll loading indicator
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.tableView addSubview:self.loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableView.contentInset = insets;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row + 1 == [self.posts count]){
        [self loadMoreData];
    }
}


- (IBAction)didTapNewPost:(id)sender {
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UITabBarController *tabBarC = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
//    self.view.window.rootViewController = tabBarC;
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    self.view.window.rootViewController = vc;
    
}
- (void) fetchPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts) {
            self.posts = posts;
            [self.tableView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    [self.refreshControl endRefreshing];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.posts[indexPath.row];
    
    PFUser *user = post.author;
    [user fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        cell.usernameLabel.text = post.author.username;
    }];
    cell.captionLabel.text = post.caption;
    
    //format date
    NSString *createdAtString = cell.timestampLabel.text = post.createdAt.description;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    NSDate *date = [formatter dateFromString:createdAtString];
    cell.timestampLabel.text = date.shortTimeAgoSinceNow;
    
    NSURL *imageURL = [NSURL URLWithString:post.image.url];
    [cell.postImage setImageWithURL:imageURL];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqual:@"PostDetailSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        
        DetailViewController *detailViewController = [segue destinationViewController];
        Post *postDetails  = self.posts[indexPath.row];
        detailViewController.post = postDetails;
    }
    
}

@end
