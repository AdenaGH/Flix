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
    
    
    NSString *backdropSuffix = self.movie[@"backdrop_path"];
    NSString *backdropImage = [baseURLString stringByAppendingString:backdropSuffix];
    NSURL *backdropURL = [NSURL URLWithString:backdropImage];
    [self.backdropView setImageWithURL:backdropURL];
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    self.ratingLabel.text = [NSString stringWithFormat:@"%@", self.movie[@"vote_average"]];
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
