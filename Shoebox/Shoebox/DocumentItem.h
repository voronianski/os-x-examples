//
//  DocumentItem.h
//  Shoebox
//
//  Created by Dmitri Voronianski on 15.10.14.
//  Copyright (c) 2014 Dmitri Voronianski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Document;

@interface DocumentItem : NSObject

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, weak) Document *document;

- (NSImage *)thumbnailImage;

@end
