//
//  ViewController.m
//  颜色渐变
//
//  Created by xunyunedu on 2017/5/16.
//  Copyright © 2017年 xunyunedu. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+RTTint.h"
#define LSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface ViewController (){
    NSTimer        *backgroundTimer;
    UIImage *tinted;
    int backgroundCount ;
    CGFloat beforeHue;
    CGFloat beforeSaturation;
    CGFloat beforeBrightness;
    CGFloat beforeAlpha;
    CGFloat AfterHue;
    CGFloat AfterSaturation;
    CGFloat AfterBrightness;
    CGFloat AfterAlpha;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    backgroundCount = 0;
    NSDate *nowDate = [NSDate date];
    backgroundTimer = [[NSTimer alloc] initWithFireDate:nowDate interval:0.01 target:self selector:@selector(drawBackgroundFountion) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:backgroundTimer forMode:NSRunLoopCommonModes];
    //1.RGB 转换为 HSV
    

    
}

-(void)drawBackgroundFountion{
    backgroundCount++;
    UIColor *testColor =  LSColor(201, 237, 205);
    UIColor *blueColer = LSColor(58, 58, 58);
    BOOL success = [testColor getHue:&beforeHue saturation:&beforeSaturation brightness:&beforeBrightness alpha:&beforeAlpha];
    if (success) {
        NSLog(@"success: hue: %0.2f, saturation: %0.2f, brightness: %0.2f, alpha: %0.2f", beforeHue, beforeSaturation, beforeBrightness, beforeAlpha);
    }else{
        NSLog(@"failed!!!!");
    }
    BOOL bluesuccess = [blueColer getHue:&AfterHue saturation:&AfterSaturation brightness:&AfterBrightness alpha:&AfterAlpha];
    if (bluesuccess) {
        NSLog(@"success: hue: %0.2f, saturation: %0.2f, brightness: %0.2f, alpha: %0.2f", AfterHue, AfterSaturation, AfterBrightness, AfterAlpha);
    }else{
        NSLog(@"failed!!!!");
    }
    //输出结果为：success: hue: 0.10, saturation: 0.79, brightness: 0.53, alpha: 1.00
    //2.HSV 转换为 RGB
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    red = beforeHue + (AfterHue - beforeHue) * backgroundCount/100.0;
    green = beforeSaturation + (AfterSaturation - beforeSaturation) *backgroundCount/100.0;
    blue = beforeBrightness + (AfterBrightness - beforeBrightness) *backgroundCount/100.0;
    UIColor *testColorh = [UIColor colorWithHue:red saturation:green brightness:blue alpha:1.00];
    BOOL success1 = [testColorh getRed:&red green:&green blue:&blue alpha:&AfterAlpha];
    if (success1) {
        NSLog(@"success: red: %0.2f,green: %0.2f, blue: %0.2f , alpha: %0.2f",red,green,blue,AfterAlpha);
        _imageView.backgroundColor =testColorh;
    }else
    {
        NSLog(@"failed!!!!");
    }

    if (backgroundCount == 100) {
        [backgroundTimer invalidate];
        backgroundTimer = nil;
    }
}

-(void)test{
    //    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor grayColor].CGColor];
    //    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    //    gradientLayer.startPoint = CGPointMake(0, 0);
    //    gradientLayer.endPoint = CGPointMake(1.0, 0);
    //    gradientLayer.frame = CGRectMake(0, 100, 300, 100);
    //    [self.view.layer addSublayer:gradientLayer];
    
    //创建CGContextRef
    //    UIGraphicsBeginImageContext(self.view.bounds.size);
    //    CGContextRef gc = UIGraphicsGetCurrentContext();
    //
    //    //创建CGMutablePathRef
    //    CGMutablePathRef path = CGPathCreateMutable();
    //
    //    //绘制Path
    //    CGRect rect = CGRectMake(0, 100, 300, 300);
    //    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    //    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    //    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
    //    CGPathAddLineToPoint(path, NULL, 20, 20);
    //
    //                         //绘制渐变
    //                         [self drawLinearGradient:gc path:path startColor:[UIColor greenColor].CGColor endColor:[UIColor redColor].CGColor];
    //
    //                         //注意释放CGMutablePathRef
    //                         CGPathRelease(path);
    //
    //                         //从Context中获取图像，并显示在界面上
    //                         UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    //                         UIGraphicsEndImageContext();
    //
    //                         UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    //                         [self.view addSubview:imgView];
    
    //    backgroundCount = 0;
    //    NSDate *nowDate = [NSDate date];
    //    backgroundTimer = [[NSTimer alloc] initWithFireDate:nowDate interval:1.0/100 target:self selector:@selector(drawBackgroundFountion) userInfo:nil repeats:YES];
    //    [[NSRunLoop currentRunLoop] addTimer:backgroundTimer forMode:NSRunLoopCommonModes];
}






- (UIImage*) BgImageFromColors:(NSArray*)colors withFrame: (CGRect)frame

{
    
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        
        [ar addObject:(id)c.CGColor];
        
    }
    
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    
    CGPoint end;
    
    
    
    start = CGPointMake(0.0, frame.size.height);
    
    end = CGPointMake(frame.size.width, 0.0);
    
    
    
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
@end
