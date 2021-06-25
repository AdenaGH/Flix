//
//  DetailsViewController.m
//  Flix
//
//  Created by Adena Rowana Ninvalle on 6/24/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (nonatomic, strong) NSDictionary *videos;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/original";
    
    NSString *posterSuffix = self.movie[@"poster_path"];
    NSString *posterImage = [baseURLString stringByAppendingString:posterSuffix];
    NSURL *posterURL = [NSURL URLWithString:posterImage];
    [self.posterView setImageWithURL:posterURL];
    
    NSString *movieID = [NSString stringWithFormat:@"%@", self.movie[@"id"]];
    //NSInteger *realID = (NSInteger *) movieID;
    NSString *backdropSuffix = self.movie[@"backdrop_path"];
    NSString *backdropImage = [baseURLString stringByAppendingString:backdropSuffix];
    NSURL *backdropURL = [NSURL URLWithString:backdropImage];
    [self.backdropView setImageWithURL:backdropURL];
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    self.ratingLabel.text = [NSString stringWithFormat:@"%@", self.movie[@"vote_average"]];
    self.releaseLabel.text = self.movie[@"release_date"];
}

/* -(void)fetchMovieInfo {
    //[self.loadingIndicator startAnimating];
    NSString *vidBase = @"https://api.themoviedb.org/3/movie/";
    NSString *movieID = [NSString stringWithFormat:@"%@", self.movie[@"id"]];
    NSString *vidTrailer = [vidBase stringByAppendingString:movieID];
    NSString *vidEnd = @"/videos?api_key=9ddcd453f18543778f55fdb2654feb24";
    NSString *fullVidLink = [vidTrailer stringByAppendingString:vidEnd];

    NSURL *vidURL = [NSURL URLWithString:fullVidLink];

    NSURLRequest *request = [NSURLRequest requestWithURL:vidURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               
           }
           else {
               NSDictionary *movieInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               //NSLog(@"%@", dataDictionary);
               self.videos = movieInfo;
               for (NSDictionary *vid in self.videos) {
                   NSLog(@"%@", vid);
               }
               //[self.view reloadData]; //calls data source methods again
            
           }
       }];
   
    //[self.refreshControl endRefreshing];
    [task resume];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
