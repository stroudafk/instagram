//
//  LoginViewController.m
//  instagram
//
//  Created by Sj Stroud on 7/6/21.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapLogin:(id)sender {

    [self checkUserFields];

    [self loginUser];
}


- (IBAction)didTapSignUp:(id)sender {
    
    [self checkUserFields];
    
    [self registerUser];
}

- (void)loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            //TODO: display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            //TODO: show banner "please enter a username/password" if username or password fields are empty
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

-(void)checkUserFields {
    //create alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty username field" message:@"Please enter your username" preferredStyle:(UIAlertControllerStyleAlert)];
    //create button(s)
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"aight" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
    //add button(s)
    [alert addAction:okAction];
    
    if([self.usernameTextField.text isEqual:@""] && [self.passwordTextField.text isEqual:@""]){
        //create alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty username and passwords fields" message:@"Please enter a username and password." preferredStyle:(UIAlertControllerStyleAlert)];
        //create button(s)
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Alrighty" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
        //add button(s)
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
    else if([self.usernameTextField.text isEqual:@""]){
        //create alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty username field" message:@"Please enter your username." preferredStyle:(UIAlertControllerStyleAlert)];
        //create button(s)
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Alrighty" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
        //add button(s)
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
    
    else if([self.passwordTextField.text isEqual:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty password field" message:@"Please enter your password." preferredStyle:(UIAlertControllerStyleAlert)];
        //create button(s)
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Alrighty" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
        //add button(s)
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
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
