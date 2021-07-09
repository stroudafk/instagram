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

@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource>
- (IBAction)didTapLogout:(id)sender;
- (IBAction)didTapNewPost:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

- (IBAction)didTapNewPost:(id)sender {
    //TODO: open NewPostViewController
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabBarC = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    self.view.window.rootViewController = tabBarC;
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.posts[indexPath.section];
    cell.captionLabel.text = post.caption;
    
    NSURL *imageURL = [NSURL URLWithString:post.image.url];
    [cell.postImage setImageWithURL:imageURL];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}

- (void) fetchPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts) {
            self.posts = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

@end
