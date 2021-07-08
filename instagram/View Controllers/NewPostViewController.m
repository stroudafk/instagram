//
//  NewPostViewController.m
//  instagram
//
//  Created by Sj Stroud on 7/7/21.
//

#import "NewPostViewController.h"
#import "Post.h"

@interface NewPostViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)didImageView:(id)sender;
- (IBAction)didTapPost:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextView *captionTextField;
- (IBAction)didTapCancel:(id)sender;



@end

@implementation NewPostViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapCancel:(id)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapPost:(id)sender {
    [Post postUserImage:self.postImage.image withCaption:self.captionTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"Sucessful post");
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else{
            NSLog(@"Failed to post");
            //todo: create pop up notification that they are unable to post right now
        }
    }];
}

- (IBAction)didImageView:(id)sender {
    NSLog(@"tapped image view");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *resizedImage = [self resizeImage:editedImage withSize:self.postImage.frame.size];
    //TODO: resize image for parse, then send to parse

    [self.postImage setImage:resizedImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
