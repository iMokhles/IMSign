//
//  DragView.h
//  AppInstaller
//
//  Created by Artem on 04/12/14.
//  Copyright (c) 2014 Globus-ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>


@protocol DragViewDelegate;
@interface DragView : NSView
@property (assign, nonatomic) BOOL dragAndDropEnabled;
@property (weak, nonatomic) IBOutlet id <DragViewDelegate> delegate;

@end

@protocol DragViewDelegate <NSObject>
- (void)draggedFileAtPath:(NSURL *)path;
@end
