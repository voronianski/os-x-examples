//
//  Document.h
//  Shoebox
//
//  Created by Dmitri Voronianski on 14.10.14.
//  Copyright (c) 2014 Dmitri Voronianski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument

- (NSImage *)thumbnailImageForName:(NSString *)fileName;

@end

