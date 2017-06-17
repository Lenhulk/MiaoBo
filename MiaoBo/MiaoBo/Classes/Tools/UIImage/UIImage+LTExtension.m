//
//  UIViewController+LTExtension.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/2.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "UIImage+LTExtension.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (LTExtension)

+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;
{
    // 模糊度越界
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}


+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    
    //获取原图的宽高
    CGSize oriImgSize = originImage.size;
    CGFloat oriImgWH = oriImgSize.width;
    //利用上下文添加背景并裁剪
    UIGraphicsBeginImageContextWithOptions(oriImgSize, NO, 0);
    //开启一个大圆并绘制背景颜色
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, oriImgWH, oriImgWH)];
    [borderColor set];
    [path fill];
    //裁剪原图中间的区域(牺牲原图上下左右4点像素)
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, oriImgWH - borderWidth*2, oriImgWH - borderWidth*2)];
    [clipPath addClip];
    //绘制图片到原图
    [originImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    //从上下文获取合成的图片
    UIImage *ovalBorderImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ovalBorderImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    if (color) {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        //开启图片上下文
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        //设置上下文填充颜色
        CGContextSetFillColorWithColor(context, color.CGColor);
        //填充颜色
        CGContextFillRect(context, rect);
        //获取图片
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        return img;
    }
    return nil;
}


@end
