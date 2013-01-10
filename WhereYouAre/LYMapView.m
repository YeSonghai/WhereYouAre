//
//  LYMapView.m
//  WhereYouAre
//
//  Created by Sean.Yie on 13-1-6.
//  Copyright (c) 2013年 Sean.Yie. All rights reserved.
//

#import "LYMapView.h"

@implementation LYMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma get Map Items
//- (RTTMapPointAnnotation*) getSelectedAnnotation
//{
//    return self.pCurrentlySelectedAnnotation;
//}

- (CLLocationCoordinate2D) getCurLocation
{
    //NSLog(@"UserLocation=%.6f, %.6f", self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude);
    
    if ((self.userLocation == nil) || [self checkIfLocOutofRange])
    {
        CLLocationCoordinate2D locShenzhenCenter = {22.549325, 114.0662};
        return locShenzhenCenter;
    }
    else
    {
        return self.userLocation.coordinate;
    }
}


- (BOOL) checkIfLocOutofRange
{
    if (!((self.userLocation.location.coordinate.latitude >= 18.0 && self.userLocation.location.coordinate.latitude <= 54.0)
          && (self.userLocation.location.coordinate.longitude >= 73.0 && self.userLocation.location.coordinate.longitude <= 135.0)) )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma mark -
#pragma mark Process View for Map

- (void) setCenterOfMapView:(CLLocationCoordinate2D)coordinate
{
    //Lon: 73-135, Lat:18-54
    if ((coordinate.latitude >= 18.0 && coordinate.latitude <= 54.0)
        && (coordinate.longitude >= 73.0 && coordinate.longitude <= 135.0) )
    {
        [self setCenterCoordinate:coordinate animated:0];
    }
    
}


- (void) removeAllUndefAnnotation
{
    if (self.undefinePointAnn != nil)
    {
        [self removeAnnotation:self.undefinePointAnn];
        self.undefinePointAnn = nil;
    }
}


- (LYMapPointAnnotation*) addAnnotation2Map:(CLLocationCoordinate2D)coordinate withType:(enum LYEN_MAPPOINTTYPE) type addr:(NSString*) addrTxt
{
    __autoreleasing LYMapPointAnnotation *pointAnnotation = [[LYMapPointAnnotation alloc] init];
    pointAnnotation.coordinate = coordinate;
    
    switch (type) {
        case MAPPOINTTYPE_FRIEND:
        {
            pointAnnotation.pointType = MAPPOINTTYPE_FRIEND;
            pointAnnotation.title = @"朋友";
            
            if(self.friendPointAnn)
            {
                [self removeAnnotation:self.friendPointAnn];
            }
            self.friendPointAnn = pointAnnotation;

        }
            break;
        case MAPPOINTTYPE_MEETING:
        {
            pointAnnotation.pointType = MAPPOINTTYPE_MEETING;
            pointAnnotation.title = @"汇合点";
            
            if(self.mettingPointAnn)
            {
                [self removeAnnotation:self.mettingPointAnn];
            }
            self.mettingPointAnn = pointAnnotation;

        }
            break;
            
        default:
        {
            pointAnnotation.pointType = MAPPOINTTYPE_UNDEF;
            pointAnnotation.title = @"点击设置";
            
            if(self.undefinePointAnn)
            {
                [self removeAnnotation:self.undefinePointAnn];
            }
            self.undefinePointAnn = pointAnnotation;
        }
            break;
    }
    
    if (addrTxt != nil)
    {
        pointAnnotation.addrString = [[NSString alloc] initWithString:addrTxt];
    }
    
    [self addAnnotation:pointAnnotation];
    
    return pointAnnotation;
}


- (CLLocationCoordinate2D)addUndefAnnotationWithTouchPoint:(CGPoint) touchPoint
{
    [self removeAllUndefAnnotation];
    //得到经纬度，指触摸区域
    CLLocationCoordinate2D touchMapCoordinate = [self convertPoint:touchPoint toCoordinateFromView:self];
    
    self.undefinePointAnn = [self addAnnotation2Map:touchMapCoordinate withType:MAPPOINTTYPE_UNDEF addr:nil];

    return touchMapCoordinate;
}




@end
