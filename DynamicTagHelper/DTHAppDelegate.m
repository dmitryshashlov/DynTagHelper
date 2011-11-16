//
//  DTHAppDelegate.m
//  DynamicTagHelper
//
//  Created by Dmitry Shashlov on 15.11.11.
//  Copyright (c) 2011 Notamedia. All rights reserved.
//

#import "DTHAppDelegate.h"

@implementation DTHAppDelegate

#define IS_BYTE_CHECKED(value, byteOffset) (value & 1<<byteOffset)>>byteOffset
#define RANGE_FROM_VALUE(value, range) 

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
  _tagValue = 0;
}

- (void)setTagValue:(int)value withRange:(NSRange)range
{
  unsigned int rangeFilledMask = (unsigned int)pow(2, range.location + range.length) - (unsigned int)pow(2, range.location);
  unsigned int rangeClearedMask = ~rangeFilledMask;
  
  _tagValue = _tagValue | rangeFilledMask;
  _tagValue = _tagValue & (rangeClearedMask | (unsigned int)(value<<range.location));
}

- (int)getValueRange:(int)value range:(NSRange)range
{
  unsigned int rangeFilledMask = (unsigned int)pow(2, range.location + range.length) - (unsigned int)pow(2, range.location);
  
  return (value&rangeFilledMask)>>range.location;
}

- (void)setControlsEnabled:(BOOL)enabled
{
  if (enabled) {
    _dynamicHeightCheckbox.state = NSOffState;
    [_dynamicHeightCheckbox setEnabled:YES];
    
    _dynamicWidthCheckbox.state = NSOffState;
    [_dynamicWidthCheckbox setEnabled:YES];
    
    _dynamicOffsetYGroup1.state = NSOffState;
    [_dynamicOffsetYGroup1 setEnabled:YES];
    
    _dynamicOffsetYGroup2.state = NSOffState;
    [_dynamicOffsetYGroup2 setEnabled:YES];
    
    _dynamicOffsetYGroup3.state = NSOffState;
    [_dynamicOffsetYGroup3 setEnabled:YES];
    
    _dynamicOffsetYGroup4.state = NSOffState;
    [_dynamicOffsetYGroup4 setEnabled:YES];
    
    _dynamicOffsetXGroup1.state = NSOffState;
    [_dynamicOffsetXGroup1 setEnabled:YES];
    
    _dynamicOffsetXGroup2.state = NSOffState;
    [_dynamicOffsetXGroup2 setEnabled:YES];
    
    _dynamicOffsetXGroup3.state = NSOffState;
    [_dynamicOffsetXGroup3 setEnabled:YES];
    
    _dynamicOffsetXGroup4.state = NSOffState;
    [_dynamicOffsetXGroup4 setEnabled:YES];
    
    [_maxHeightTextField setEnabled:YES];
    [_maxWidthTextField setEnabled:YES];
  } else {
    _dynamicHeightCheckbox.state = NSOffState;
    [_dynamicHeightCheckbox setEnabled:NO];
    
    _dynamicWidthCheckbox.state = NSOffState;
    [_dynamicWidthCheckbox setEnabled:NO];
    
    _dynamicOffsetYGroup1.state = NSOffState;
    [_dynamicOffsetYGroup1 setEnabled:NO];
    
    _dynamicOffsetYGroup2.state = NSOffState;
    [_dynamicOffsetYGroup2 setEnabled:NO];
    
    _dynamicOffsetYGroup3.state = NSOffState;
    [_dynamicOffsetYGroup3 setEnabled:NO];
    
    _dynamicOffsetYGroup4.state = NSOffState;
    [_dynamicOffsetYGroup4 setEnabled:NO];
    
    _dynamicOffsetXGroup1.state = NSOffState;
    [_dynamicOffsetXGroup1 setEnabled:NO];
    
    _dynamicOffsetXGroup2.state = NSOffState;
    [_dynamicOffsetXGroup2 setEnabled:NO];
    
    _dynamicOffsetXGroup3.state = NSOffState;
    [_dynamicOffsetXGroup3 setEnabled:NO];
    
    _dynamicOffsetXGroup4.state = NSOffState;
    [_dynamicOffsetXGroup4 setEnabled:NO];
    
    _maxHeightTextField.stringValue = @"";
    [_maxHeightTextField setEnabled:NO];
    
    _maxWidthTextField.stringValue = @"";
    [_maxWidthTextField setEnabled:NO];  
  }
}

- (void)controlValueChanged:(id)sender
{
  // enabled bit
  if (sender == _dynamicTagEnabledCheckbox) {
    [self setControlsEnabled:_dynamicTagEnabledCheckbox.state];
    _tagValue = _dynamicTagEnabledCheckbox.state ? _tagValue ^ 1<<30 : 0;
  }
  
  // bits from right to left
  if (sender == _dynamicHeightCheckbox) {
    _tagValue = _tagValue ^ 1<<0;
  }
  if (sender == _dynamicWidthCheckbox) {
    _tagValue = _tagValue ^ 1<<1;
  }
  
  // dynamicOffsetYGroup
  if (sender == _dynamicOffsetYGroup4) {
    _tagValue = _tagValue ^ 1<<2;
  }
  if (sender == _dynamicOffsetYGroup3) {
    _tagValue = _tagValue ^ 1<<3;
  }
  if (sender == _dynamicOffsetYGroup2) {
    _tagValue = _tagValue ^ 1<<4;
  }
  if (sender == _dynamicOffsetYGroup1) {
    _tagValue = _tagValue ^ 1<<5;
  }
  
  // dynamicOffsetXGroup
  if (sender == _dynamicOffsetXGroup4) {
    _tagValue = _tagValue ^ 1<<6;
  }
  if (sender == _dynamicOffsetXGroup3) {
    _tagValue = _tagValue ^ 1<<7;
  }
  if (sender == _dynamicOffsetXGroup2) {
    _tagValue = _tagValue ^ 1<<8;
  }
  if (sender == _dynamicOffsetXGroup1) {
    _tagValue = _tagValue ^ 1<<9;
  }
  
  // maxHeight
  if (sender == _maxHeightTextField) {
    [self setTagValue:((NSTextField *)sender).intValue
            withRange:NSRangeFromString(@"10 10")];
  }
  
  // maxWidth
  if (sender == _maxWidthTextField) {
    [self setTagValue:((NSTextField *)sender).intValue
            withRange:NSRangeFromString(@"20 10")];
  }
  
  _tagTextField.stringValue = [NSString stringWithFormat:@"%d", _tagValue];
}

- (void)tagFieldValueCHanged:(id)sender
{
  unsigned int value = ((NSTextField *)sender).intValue;
  
  BOOL isDynamic = IS_BYTE_CHECKED(value, 30);
  [self setControlsEnabled:isDynamic];
  _dynamicTagEnabledCheckbox.state = isDynamic;

  _tagValue = isDynamic ? value : 0;
  
  if (isDynamic) {
    _dynamicHeightCheckbox.state = IS_BYTE_CHECKED(value, 0);
    _dynamicWidthCheckbox.state = IS_BYTE_CHECKED(value, 1);
    
    _dynamicOffsetYGroup4.state = IS_BYTE_CHECKED(value, 2);
    _dynamicOffsetYGroup3.state = IS_BYTE_CHECKED(value, 3);
    _dynamicOffsetYGroup2.state = IS_BYTE_CHECKED(value, 4);
    _dynamicOffsetYGroup1.state = IS_BYTE_CHECKED(value, 5);
    
    _dynamicOffsetXGroup4.state = IS_BYTE_CHECKED(value, 6);
    _dynamicOffsetXGroup3.state = IS_BYTE_CHECKED(value, 7);
    _dynamicOffsetXGroup2.state = IS_BYTE_CHECKED(value, 8);
    _dynamicOffsetXGroup1.state = IS_BYTE_CHECKED(value, 9);  
    
    int maxHeight = [self getValueRange:value range:NSRangeFromString(@"10 10")];
    if (maxHeight) {
      _maxHeightTextField.intValue = maxHeight;
    } else {
      _maxHeightTextField.stringValue = @"";
    }
    
    int maxWidth = [self getValueRange:value range:NSRangeFromString(@"20 10")];
    if (maxWidth) {
      _maxWidthTextField.intValue = maxWidth;
    } else {
      _maxWidthTextField.stringValue = @"";
    }
  }
}

@end
