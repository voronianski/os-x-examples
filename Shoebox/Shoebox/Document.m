//
//  Document.m
//  Shoebox
//
//  Created by Dmitri Voronianski on 14.10.14.
//  Copyright (c) 2014 Dmitri Voronianski. All rights reserved.
//

#import "Document.h"
#import "DocumentItem.h"

@interface Document ()

@end

@implementation Document {
    NSFileWrapper *_fileWrapper;
    NSMutableArray *_items;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        _items = [[NSMutableArray alloc] init];
        _fileWrapper = [[NSFileWrapper alloc] initDirectoryWithFileWrappers:nil];
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    if (![fileWrapper isDirectory]) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Illegal Document Format" forKey:NSLocalizedDescriptionKey];
        *outError = [NSError errorWithDomain:@"Shoebox" code:1 userInfo:userInfo];
        return NO;
    }
    _fileWrapper = fileWrapper;
    NSFileWrapper *indexWrapper = [fileWrapper.fileWrappers objectForKey:@"index.plist"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:indexWrapper.regularFileContents];
    
    [array makeObjectsPerformSelector:@selector(setDocument:) withObject:self];
    
    _items = [array mutableCopy];
    
    return YES;
}

- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSMutableDictionary *files = [NSMutableDictionary dictionary];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_items];
    
    NSFileWrapper *indexWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:data];
    
    [files setObject:indexWrapper forKey:@"index.plist"];
    
    for (DocumentItem *oneItem in _items) {
        NSString *fileName = [oneItem fileName];
        NSFileWrapper *existingFile = [_fileWrapper.fileWrappers objectForKey:fileName];
        [files setObject:existingFile forKey:fileName];
    }
    
    NSFileWrapper *newWrapper = [[NSFileWrapper alloc] initDirectoryWithFileWrappers:files];
    
    return newWrapper;
}

@end
