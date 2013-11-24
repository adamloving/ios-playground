//
//  FunFirstViewController.m
//  TempTabView
//
//  Created by Adam Loving on 11/23/13.
//  Copyright (c) 2013 Adam Loving. All rights reserved.
//

#import "FunFirstViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define MAX_IMAGE_WIDTH 400

@interface FunFirstViewController() <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FunFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.scrollView setContentSize:CGSizeMake(320, 1000)];
}

- (IBAction)takePhoto:(UIBarButtonItem *)sender
{
    [self presentImagePicker:UIImagePickerControllerSourceTypeSavedPhotosAlbum sender:sender];
}

- (void)presentImagePicker:(UIImagePickerControllerSourceType)sourceType
                    sender:(UIBarButtonItem *)sender
{
    // tbd: check availableMediaTypes
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.mediaTypes = @[(NSString *)kUTTypeImage];
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    // if source type on ipad present in popover
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) image = info[UIImagePickerControllerOriginalImage];
    if (image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGRect frame = imageView.frame;
        if (frame.size.width > MAX_IMAGE_WIDTH) {
            frame.size.height = (frame.size.height / frame.size.width) * MAX_IMAGE_WIDTH;
            frame.size.width = MAX_IMAGE_WIDTH;
        }
        imageView.frame = frame;
        [self.scrollView addSubview:imageView];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
