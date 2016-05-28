//
// ChoosePersonView.m
//
// Copyright (c) 2014 to present, Brian Gesiak @modocache
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "ChoosePersonView.h"
#import "ImageLabelView.h"
#import "Person.h"

static const CGFloat ChoosePersonViewImageLabelWidth = 42.f;

@interface ChoosePersonView ()
@property (nonatomic, strong) UIView *informationView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *goalLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) ImageLabelView *cameraImageLabelView;
@property (nonatomic, strong) ImageLabelView *interestsImageLabelView;
@property (nonatomic, strong) ImageLabelView *friendsImageLabelView;
@end

@implementation ChoosePersonView

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
                       person:(Person *)person
                      options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame options:options];
    if (self) {
        _person = person;
        self.imageView.image = _person.image;

        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
                                UIViewAutoresizingFlexibleWidth |
                                UIViewAutoresizingFlexibleBottomMargin;
        self.imageView.autoresizingMask = self.autoresizingMask;

        [self constructInformationView];
    }
    return self;
}

#pragma mark - Internal Methods

- (void)constructInformationView {
    CGFloat bottomHeight = 80.f;
    CGRect bottomFrame = CGRectMake(0,
                                    CGRectGetHeight(self.bounds) - bottomHeight,
                                    CGRectGetWidth(self.bounds),
                                    bottomHeight);
    _informationView = [[UIView alloc] initWithFrame:bottomFrame];
    _informationView.backgroundColor = [UIColor whiteColor];
    _informationView.clipsToBounds = YES;
    _informationView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                        UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_informationView];

    [self constructNameLocationLabel];
    //[self constructLocationLabel];
    [self constructGoalLabel];
    [self constructDateLabel];

    //[self constructCameraImageLabelView];
    //[self constructInterestsImageLabelView];
    //[self constructFriendsImageLabelView];
}

- (void)constructNameLocationLabel {
    CGFloat leftPadding = 12.f;
    CGFloat topPadding = -20.f;
    CGRect frame = CGRectMake(leftPadding,
                              topPadding,
                              floorf(CGRectGetWidth(_informationView.frame)),
                              CGRectGetHeight(_informationView.frame) - topPadding);
    _nameLabel = [[UILabel alloc] initWithFrame:frame];
    _nameLabel.font = [UIFont boldSystemFontOfSize:14];
    _nameLabel.text = [NSString stringWithFormat:@"%@, %@ from %@", _person.name, @(_person.age), _person.location];
    [_informationView addSubview:_nameLabel];
}

- (void)constructGoalLabel {
    CGFloat rightPadding = 12.f;
    CGFloat topPadding = 20.f;
    CGRect frame = CGRectMake(rightPadding,
                              topPadding,
                              floorf(CGRectGetWidth(_informationView.frame)),
                              CGRectGetHeight(_informationView.frame) - topPadding);
    _goalLabel = [[UILabel alloc] initWithFrame:frame];
    _goalLabel.font = [UIFont systemFontOfSize:14];
    _goalLabel.text = [NSString stringWithFormat:@"Traveling to %@, %@", _person.goal, _person.city];
    [_informationView addSubview:_goalLabel];
}

- (void)constructDateLabel {
    CGFloat rightPadding = 12.f;
    CGFloat topPadding = 50.f;
    CGRect frame = CGRectMake(rightPadding,
                              topPadding,
                              floorf(CGRectGetWidth(_informationView.frame)),
                              CGRectGetHeight(_informationView.frame) - topPadding);
    _dateLabel = [[UILabel alloc] initWithFrame:frame];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.text = [NSString stringWithFormat:@"%@ - %@", _person.fromDate, _person.toDate];
    [_informationView addSubview:_dateLabel];
}

- (void)constructLocationLabel {
    CGFloat leftPadding = 12.f;
    CGFloat topPadding = 37.f;
    CGRect frame = CGRectMake(leftPadding,
                              topPadding,
                              floorf(CGRectGetWidth(_informationView.frame)/2),
                              CGRectGetHeight(_informationView.frame) - topPadding);
    _locationLabel = [[UILabel alloc] initWithFrame:frame];
    _locationLabel.font = [UIFont systemFontOfSize:12];
    _locationLabel.text = [NSString stringWithFormat:@"%@", _person.location];
    [_informationView addSubview:_locationLabel];
}

- (void)constructCameraImageLabelView {
    CGFloat rightPadding = 10.f;
    UIImage *image = [UIImage imageNamed:@"camera"];
    _cameraImageLabelView = [self buildImageLabelViewLeftOf:CGRectGetWidth(_informationView.bounds) - rightPadding
                                                      image:image
                                                       text:[@(_person.numberOfPhotos) stringValue]];
    [_informationView addSubview:_cameraImageLabelView];
}

- (void)constructInterestsImageLabelView {
    UIImage *image = [UIImage imageNamed:@"book"];
    _interestsImageLabelView = [self buildImageLabelViewLeftOf:CGRectGetMinX(_cameraImageLabelView.frame)
                                                         image:image
                                                          text:[@(_person.numberOfPhotos) stringValue]];
    [_informationView addSubview:_interestsImageLabelView];
}

- (void)constructFriendsImageLabelView {
    UIImage *image = [UIImage imageNamed:@"group"];
    _friendsImageLabelView = [self buildImageLabelViewLeftOf:CGRectGetMinX(_interestsImageLabelView.frame)
                                                      image:image
                                                       text:[@(_person.numberOfSharedFriends) stringValue]];
    [_informationView addSubview:_friendsImageLabelView];
}

- (ImageLabelView *)buildImageLabelViewLeftOf:(CGFloat)x image:(UIImage *)image text:(NSString *)text {
    CGRect frame = CGRectMake(x - ChoosePersonViewImageLabelWidth,
                              0,
                              ChoosePersonViewImageLabelWidth,
                              CGRectGetHeight(_informationView.bounds));
    ImageLabelView *view = [[ImageLabelView alloc] initWithFrame:frame
                                                           image:image
                                                            text:text];
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    return view;
}

@end
