//
//  DragView.m
//  AppInstaller
//
//  Created by Artem on 04/12/14.
//  Copyright (c) 2014 Globus-ltd. All rights reserved.
//

#import "DragView.h"

@interface DragView () <NSDraggingDestination>
@property (nonatomic, assign) BOOL draggingEntered;

@end
@implementation DragView

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.dragAndDropEnabled = YES;
        [self registerForDraggedTypes:@[@"com.apple.iTunes.ipa", NSFilenamesPboardType]];
    }
    return self;
}

-(void)drawRect:(NSRect)rect {
    [super drawRect:rect];
    [[NSColor clearColor] setFill];
    NSRectFillUsingOperation(rect, NSCompositeSourceOver);
}
#pragma mark - NSDraggingDestination

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
   
    if (!self.dragAndDropEnabled) {
        return NSDragOperationNone;
    }
    
    return NSDragOperationCopy;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
    
    if (!self.dragAndDropEnabled) {
        return;
    }
    
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    
    if (!self.dragAndDropEnabled) {
        return;
    }
}


- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    
    if (!self.dragAndDropEnabled) {
        return NO;
    }
    
    NSPasteboard *pastboard = [sender draggingPasteboard];
    
    NSURL *url = [NSURL URLFromPasteboard:pastboard];
    
    if ([self.delegate respondsToSelector:@selector(draggedFileAtPath:)]) {
        [self.delegate draggedFileAtPath:url];
    }
    
    return YES;
}

@end
