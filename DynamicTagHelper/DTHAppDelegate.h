//
//  DTHAppDelegate.h
//  DynamicTagHelper
//
//  Created by Dmitry Shashlov on 15.11.11.
//  Copyright (c) 2011 Notamedia. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DTHAppDelegate : NSObject <NSApplicationDelegate> {
  NSInteger           _tagValue;
  
  IBOutlet NSButton*  _dynamicTagEnabledCheckbox;
  
  IBOutlet NSButton*  _dynamicWidthCheckbox;
  IBOutlet NSButton*  _dynamicHeightCheckbox;
  
  IBOutlet NSButton*  _dynamicOffsetXGroup1;
  IBOutlet NSButton*  _dynamicOffsetXGroup2;
  IBOutlet NSButton*  _dynamicOffsetXGroup3;
  IBOutlet NSButton*  _dynamicOffsetXGroup4;
  
  IBOutlet NSButton*  _dynamicOffsetYGroup1;
  IBOutlet NSButton*  _dynamicOffsetYGroup2;
  IBOutlet NSButton*  _dynamicOffsetYGroup3;
  IBOutlet NSButton*  _dynamicOffsetYGroup4;
  
  IBOutlet NSTextField*  _maxWidthTextField;
  IBOutlet NSTextField*  _maxHeightTextField;
  
  IBOutlet NSTextField*  _tagTextField;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)controlValueChanged:(id)sender;
- (IBAction)tagFieldValueCHanged:(id)sender;

@end
