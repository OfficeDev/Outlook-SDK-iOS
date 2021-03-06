/*******************************************************************************
**NOTE** This code was generated by a tool and will occasionally be
overwritten. We welcome comments and issues regarding this code; they will be
addressed in the generation tool. If you wish to submit pull requests, please
do so for the templates in that tool.

This code was generated by Vipr (https://github.com/microsoft/vipr) using
the T4TemplateWriter (https://github.com/msopentech/vipr-t4templatewriter).

Copyright (c) Microsoft Corporation. All Rights Reserved.
Licensed under the Apache License 2.0; see LICENSE in the source repository
root for authoritative license information.﻿
******************************************************************************/



#import "MSOutlookFreeBusyStatus.h"

@implementation MSOutlookFreeBusyStatusSerializer

+(MSOutlookFreeBusyStatus) fromString:(NSString *) string {

    static NSDictionary *stringMappings=nil;
    
    if(stringMappings==nil)
    {
        stringMappings=[[NSDictionary alloc] initWithObjectsAndKeys:
         [NSNumber numberWithInt:MSOutlookFreeBusyStatusFree], @"Free", [NSNumber numberWithInt:MSOutlookFreeBusyStatusTentative], @"Tentative", [NSNumber numberWithInt:MSOutlookFreeBusyStatusBusy], @"Busy", [NSNumber numberWithInt:MSOutlookFreeBusyStatusOof], @"Oof", [NSNumber numberWithInt:MSOutlookFreeBusyStatusWorkingElsewhere], @"WorkingElsewhere", [NSNumber numberWithInt:MSOutlookFreeBusyStatusUnknown], @"Unknown",
            nil        
        ];
    }
    
    return [stringMappings[string] intValue];

}

+(NSString *) toString: (MSOutlookFreeBusyStatus) value {

    static NSDictionary *stringMappings=nil;
    
    if(stringMappings==nil)
    {
        stringMappings=[[NSDictionary alloc] initWithObjectsAndKeys:
         @"Free", [NSNumber numberWithInt:MSOutlookFreeBusyStatusFree], @"Tentative", [NSNumber numberWithInt:MSOutlookFreeBusyStatusTentative], @"Busy", [NSNumber numberWithInt:MSOutlookFreeBusyStatusBusy], @"Oof", [NSNumber numberWithInt:MSOutlookFreeBusyStatusOof], @"WorkingElsewhere", [NSNumber numberWithInt:MSOutlookFreeBusyStatusWorkingElsewhere], @"Unknown", [NSNumber numberWithInt:MSOutlookFreeBusyStatusUnknown],
            nil        
        ];
    }
    
    return stringMappings[[NSNumber numberWithInt:value]];
}

@end

