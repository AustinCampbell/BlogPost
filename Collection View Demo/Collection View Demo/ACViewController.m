//
//  ACViewController.m
//  Collection View Demo
//
//  Created by Austin Campbell on 5/27/14.
//  Copyright (c) 2014 Austin Campbell. All rights reserved.
//

#import "ACViewController.h"
#import "ACPhotoCell.h"
#import <MessageUI/MessageUI.h>

@interface ViewController() <UICollectionViewDataSource,
                            UICollectionViewDelegate,
                            UICollectionViewDelegateFlowLayout,
                            MFMailComposeViewControllerDelegate,
                            MFMessageComposeViewControllerDelegate,
                            UINavigationControllerDelegate>

@property (nonatomic) BOOL flipped;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, weak) IBOutlet UILabel *feedbackMsg;
@end

@implementation ViewController

- (UIImage *)imageForURL:(NSURL *)puppyURL
{
    NSData *puppyData = [NSData dataWithContentsOfURL:puppyURL];
    UIImage *puppyImage = [UIImage imageWithData:puppyData];
    return puppyImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _photos = [NSMutableArray new];
    
    NSURL *puppy0URL = [NSURL URLWithString:@"http://images4.fanpop.com/image/photos/14700000/Sweet-puppy-with-bunny-puppies-14749075-1600-1200.jpg"];
    NSURL *puppy1URL = [NSURL URLWithString:@"http://sarajade.com/wp-content/uploads/2013/04/shibainuinabasket.jpg"];
    
    for (int i=0; i<10; i++) {
        NSURL *puppyURL = i % 2 ? puppy0URL : puppy1URL;
        [_photos addObject:puppyURL];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSURL *puppyURL = _photos[indexPath.row];
    cell.puppyView.image = [self imageForURL:puppyURL];
    
    cell.layer.borderWidth = 2.f;
    cell.layer.borderColor = [UIColor colorWithRed:0.267 green:0.522 blue:0.965 alpha:1].CGColor;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row % 2) {
    //        return CGSizeMake(80, 80);
    //    } else {
    //        return CGSizeMake(80, 220);
    //    }
    if (_flipped) {
        return indexPath.row % 2 ? CGSizeMake(80, 80) : CGSizeMake(80, 220);
    } else {
        return indexPath.row % 2 ? CGSizeMake(80, 220) : CGSizeMake(80, 80);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView performBatchUpdates:^{
        _flipped = !_flipped;
        [collectionView reloadData];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - mail and message setup

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
		self.feedbackMsg.text = @"Cannot send mail.";
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
		self.feedbackMsg.text = @"Cannot text.";
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
	
	[picker setSubject:@"Super cute puppies"];
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"];
    
	
	[picker setToRecipients:toRecipients];
    
	
	// Attach an image to the email
	NSString *path = [[NSBundle mainBundle] pathForResource:@"http://sarajade.com/wp-content/uploads/2013/04/shibainuinabasket.jpg" ofType:@"jpg"];
	NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
	
	// Fill out the email body text
	NSString *emailBody = @"It is raining in sunny California!";
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
    picker.body = @"Hello from California!";
    
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