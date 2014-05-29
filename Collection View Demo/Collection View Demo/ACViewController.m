//
//  ACViewController.m
//  Collection View Demo
//
//  Created by Austin Campbell on 5/27/14.
//  Copyright (c) 2014 Austin Campbell. All rights reserved.
//

#import "ACViewController.h"
#import "ACPhotoCell.h"

@interface ACViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) BOOL flipped;
@property (nonatomic, weak)IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *photos;


@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _photos = [NSMutableArray new];
    
    NSURL *puppy0URL = [NSURL URLWithString:@"http://images2.fanpop.com/image/photos/9700000/Sad-Puppy-puppies-9726248-1600-1200.jpg"];
    
    NSURL *puppy1URL = [NSURL URLWithString:@"http://images2.fanpop.com/image/photos/9400000/Aaaaaawwwwwwwwww-Sweet-puppies-9415255-1600-1200.jpg"];
    
    for (int i=0; i<10; i++) {
        
        NSURL *puppyURL = i % 2 ? puppy0URL : puppy1URL;
        NSData *puppyData = [NSData dataWithContentsOfURL:puppyURL];
        UIImage *puppyImage = [UIImage imageWithData:puppyData];
        [_photos addObject:puppyImage];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    
    // return _photos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    ACPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row % 2) {
        NSLog(@"Puppy 1");
        cell.puppyView.image = [UIImage imageNamed:@"puppy0.jpg"];
    } else {
        NSLog(@"Puppy 2");
        cell.puppyView.image = [UIImage imageNamed:@"puppy1.jpg"];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//       if (_flipped) {
//        if (indexPath.row % 2) {
//            
//            return CGSizeMake(50, 100);
//            
//        } else {
//            
//            return CGSizeMake(50, 50);
//        }
//
//    } else {
//        if (!indexPath.row % 2) {
//            
//            return CGSizeMake(50, 100);
//            
//        } else {
//            
//            return CGSizeMake(50, 50);
//        }
//    }
    
    if (self.flipped) {
        return indexPath.row % 2 ? CGSizeMake(80.0, 80.0) : CGSizeMake(80.0, 220);
    } else {
        return indexPath.row % 2 ? CGSizeMake(80.0, 220.0) : CGSizeMake(80.0, 80.0);
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

@end


