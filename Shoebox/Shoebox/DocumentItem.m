//
//  DocumentItem.m
//  Shoebox
//
//  Created by Dmitri Voronianski on 15.10.14.
//  Copyright (c) 2014 Dmitri Voronianski. All rights reserved.
//

#import "DocumentItem.h"
#import "Document.h"

@implementation DocumentItem

- (NSImage *)thumbnailImage {
    return [self.document thumbnailImageForName:self.fileName];
}

# pragma mark NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.fileName = [aDecoder decodeObjectForKey:@"fileName"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.fileName forKey:@"fileName"];
}

@end
