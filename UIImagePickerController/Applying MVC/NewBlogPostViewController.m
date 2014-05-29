//
//  NewBlogPostViewController.m
//  Applying MVC
//
//  Created by Austin Campbell on 5/12/14.
//  Copyright (c) 2014 Code Follows. All rights reserved.
//

#import "NewBlogPostViewController.h"
#import "UIImage+ImageEffects.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MessageUI/MessageUI.h>

@interface NewBlogPostViewController ()<UIImagePickerControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,
UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, weak) IBOutlet UILabel *feedbackMsg;


@end

@implementation NewBlogPostViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    if (self.textField.text.length > 0) {
        self.post = [[Post alloc] init];
        self.post.title = self.textField.text;
    }
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Photo Library"]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

-(IBAction)showImagePicker:(id)sender
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Source Type"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Photo Library", @"Camera", nil];
        [actionSheet showFromBarButtonItem:sender animated:YES];
    } else {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }
    
}

-(void)saveImageToLibrary:(UIImage *)editedImage
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary writeImageToSavedPhotosAlbum:editedImage.CGImage
                                    orientation:ALAssetOrientationUp
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    NSLog(@"Asset URL: %@", assetURL);
                                }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        editedImage = [editedImage applyTintEffectWithColor:[UIColor orangeColor]];
        
        _imageView.image = editedImage;
        _imageView.layer.cornerRadius = _imageView.frame.size.width / 2.0;
        [_imageView setClipsToBounds:YES];
        
        [self saveImageToLibrary:editedImage];
        
        
        
    }];
}

-(IBAction)showShareSheet:(id)sender
{
    if (_imageView.image) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[_imageView.image, @"Picture"] applicationActivities:nil];
        
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Rotation

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
// -------------------------------------------------------------------------------
//	shouldAutorotateToInterfaceOrientation:
//  Disable rotation on iOS 5.x and earlier.  Note, for iOS 6.0 and later all you
//  need is "UISupportedInterfaceOrientations" defined in your Info.plist
// -------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#endif

#pragma mark - Actions

// -------------------------------------------------------------------------------
//	showMailPicker:
//  IBAction for the Compose Mail button.
// -------------------------------------------------------------------------------
- (IBAction)showMailPicker:(id)sender
{
    // You must check that the current device can send email messages before you
    // attempt to create an instance of MFMailComposeViewController.  If the
    // device can not send email messages,
    // [[MFMailComposeViewController alloc] init] will return nil.  Your app
    // will crash when it calls -presentViewController:animated:completion: with
    // a nil view controller.
    if ([MFMailComposeViewController canSendMail])
        // The device can send email.
    {
        [self displayMailComposerSheet];
    }
    else
        // The device can not send email.
    {
        self.feedbackMsg.hidden = NO;
		self.feedbackMsg.text = @"Device not configured to send mail.";
    }
}

// -------------------------------------------------------------------------------
//	showSMSPicker:
//  IBAction for the Compose SMS button.
// -------------------------------------------------------------------------------
- (IBAction)showSMSPicker:(id)sender
{
    // You must check that the current device can send SMS messages before you
    // attempt to create an instance of MFMessageComposeViewController.  If the
    // device can not send SMS messages,
    // [[MFMessageComposeViewController alloc] init] will return nil.  Your app
    // will crash when it calls -presentViewController:animated:completion: with
    // a nil view controller.
    if ([MFMessageComposeViewController canSendText])
        // The device can send email.
    {
        [self displaySMSComposerSheet];
    }
    else
        // The device can not send email.
    {
        self.feedbackMsg.hidden = NO;
		self.feedbackMsg.text = @"Device not configured to send SMS.";
    }
}

#pragma mark - Compose Mail/SMS

// -------------------------------------------------------------------------------
//	displayMailComposerSheet
//  Displays an email composition interface inside the application.
//  Populates all the Mail fields.
// -------------------------------------------------------------------------------
- (void)displayMailComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Look at this cute puppy"];
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"];
//	NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
//	NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
	
	[picker setToRecipients:toRecipients];
//	[picker setCcRecipients:ccRecipients];
//	[picker setBccRecipients:bccRecipients];
	
    
	// Attach an image to the email
	NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3013" ofType:@"jpg"];
	NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"IMG_3013"];
	
	// Fill out the email body text
	NSString *emailBody = @"Here is an email about cute puppies!";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentViewController:picker animated:YES completion:NULL];
}

// -------------------------------------------------------------------------------
//	displayMailComposerSheet
//  Displays an SMS composition interface inside the application.
// -------------------------------------------------------------------------------
- (void)displaySMSComposerSheet
{
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;
	
    // You can specify one or more preconfigured recipients.  The user has
    // the option to remove or add recipients from the message composer view
    // controller.
    /* picker.recipients = @[@"Phone number here"]; */
    
    // You can specify the initial message text that will appear in the message
    // composer view controller.
    picker.body = @"Hello World";
    
	[self presentViewController:picker animated:YES completion:NULL];
}


#pragma mark - Delegate Methods

// -------------------------------------------------------------------------------
//	mailComposeController:didFinishWithResult:
//  Dismisses the email composition interface when users tap Cancel or Send.
//  Proceeds to update the message field with the result of the operation.
// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	self.feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			self.feedbackMsg.text = @"Result: Mail sending canceled";
			break;
		case MFMailComposeResultSaved:
			self.feedbackMsg.text = @"Result: Mail saved";
			break;
		case MFMailComposeResultSent:
			self.feedbackMsg.text = @"Result: Mail sent";
			break;
		case MFMailComposeResultFailed:
			self.feedbackMsg.text = @"Result: Mail sending failed";
			break;
		default:
			self.feedbackMsg.text = @"Result: Mail not sent";
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}

// -------------------------------------------------------------------------------
//	messageComposeViewController:didFinishWithResult:
//  Dismisses the message composition interface when users tap Cancel or Send.
//  Proceeds to update the feedback message field with the result of the
//  operation.
// -------------------------------------------------------------------------------
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
	self.feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MessageComposeResultCancelled:
			self.feedbackMsg.text = @"Result: SMS sending canceled";
			break;
		case MessageComposeResultSent:
			self.feedbackMsg.text = @"Result: SMS sent";
			break;
		case MessageComposeResultFailed:
			self.feedbackMsg.text = @"Result: SMS sending failed";
			break;
		default:
			self.feedbackMsg.text = @"Result: SMS not sent";
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}



@end


