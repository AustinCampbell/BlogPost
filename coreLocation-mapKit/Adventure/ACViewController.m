//
//  ACViewController.m
//  Adventure
//
//  Created by Austin Campbell on 5/20/14.
//  Copyright (c) 2014 Austin Campbell. All rights reserved.
//

#import "ACViewController.h"

@interface ACViewController () <CLLocationManagerDelegate, UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)CLLocationManager *locationManager;
@property (weak, nonatomic)IBOutlet MKMapView *mapView;
@property (weak, nonatomic)IBOutlet UISearchBar *searchBar;
@property(nonatomic, getter=isActive) BOOL active;
@property (strong, nonatomic)MKLocalSearchResponse *searchResponse;

@end

@implementation ACViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 100;
    self.locationManager.desiredAccuracy = 5;
    [self.locationManager startUpdatingLocation];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", locations.lastObject);
    CLLocation  *location = locations.lastObject;
    CLLocationCoordinate2D coordinate = location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 250, 250);
    [self.mapView setRegion:region animated:YES];
}

#pragma mark -SearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    [request setRegion:self.mapView.region];
    [request setNaturalLanguageQuery:searchBar.text];
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        
        if (!response.mapItems.count) {
            return;
        }
        
        self.searchResponse = response;
        [self.searchDisplayController.searchResultsTableView reloadData];
        
    }];
    
    
}

#pragma mark - SearchDisplayControllerDelegate

- (void)searchDisplayControllerWillBeginSearch: (UISearchDisplayController *)controller
{
    self.searchDisplayController.searchBar.showsCancelButton = YES;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.searchDisplayController.searchBar.showsCancelButton = NO;
}

# pragma mark - UITableViewDataSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResponse.mapItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    }
    
    MKMapItem *mapItem = self.searchResponse.mapItems[indexPath.row];
    cell.textLabel.text = mapItem.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchDisplayController setActive:NO animated:YES];
    MKMapItem *mapItem = [self.searchResponse.mapItems objectAtIndex:indexPath.row];
    MKPlacemark *placemark = [mapItem placemark];
    [self.mapView addAnnotation:placemark];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.coordinate, 1000, 1000);
    [self.mapView setRegion:region animated:YES];
}


@end
