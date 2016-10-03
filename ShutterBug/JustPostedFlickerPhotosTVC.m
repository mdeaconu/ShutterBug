//
//  JustPostedFlickerPhotosTVC.m
//  ShutterBug
//
//  Created by Mihai Deaconu on 03/10/16.
//  Copyright © 2016 Mihai Deaconu. All rights reserved.
//

#import "JustPostedFlickerPhotosTVC.h"
#import "FlickrFetcher.h"

@interface JustPostedFlickerPhotosTVC ()

@end

@implementation JustPostedFlickerPhotosTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchPhotos];
}

- (void)fetchPhotos
{
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    NSData *jsonResults = [NSData dataWithContentsOfURL:url];
    NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                        options:0
                                                                          error:NULL];
    NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
    self.photos = photos;
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
