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

- (IBAction)fetchPhotos
{
    [self.refreshControl beginRefreshing];
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    dispatch_queue_t fetchQ = dispatch_queue_create("flicker fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                            options:0
                                                                              error:NULL];
        NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            self.photos = photos;
        });
    });
}

@end
