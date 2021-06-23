//
//  MoviesViewController.m
//  Flix
//
//  Created by Adena Rowana Ninvalle on 6/23/21.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Links the correct view controller thing to self
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    //[self.tableView addSubview:self.refreshControl];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

}

-(void)fetchMovies {
    [self.loadingIndicator startAnimating];
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=9ddcd453f18543778f55fdb2654feb24"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               //NSLog(@"%@", dataDictionary);
               self.movies =dataDictionary[@"results"];
               for (NSDictionary *movie in self.movies) {
                   NSLog(@"%@", movie);
               }
               [self.tableView reloadData]; //calls data source methods again
               // TODO: Get the array of movies DONE see line 13
               // TODO: Store the movies in a property to use elsewhere DONE
               // TODO: Reload your table view data DONE: see line 40
           }
       }];
   
    [self.refreshControl endRefreshing];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //makes it the cell we made
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie =self.movies[indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.Synopsis.text = movie[@"overview"];
    cell.ratingLabel.text = [NSString stringWithFormat:@"%@",movie[@"vote_average"]];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/original";
    
    NSString *posterSuffix = movie[@"poster_path"];
    NSString *posterImage = [baseURLString stringByAppendingString:posterSuffix];
    NSURL *posterURL = [NSURL URLWithString:posterImage];
    [cell.posterView setImageWithURL:posterURL];
    
    //cell.textLabel.text = movie[@"title"];
    [self.loadingIndicator stopAnimating];
    return cell;
    
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
