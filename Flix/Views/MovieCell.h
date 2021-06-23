//
//  MovieCell.h
//  Flix
//
//  Created by Adena Rowana Ninvalle on 6/23/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *Synopsis;

@end

NS_ASSUME_NONNULL_END
