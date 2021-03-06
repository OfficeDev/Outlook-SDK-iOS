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



#import "MSOutlookModels.h"
#import "core/MSOrcObjectizer.h"


/** Implementation for MSOutlookReminder
 *
 */
@implementation MSOutlookReminder


@synthesize odataType = _odataType;

+ (NSDictionary *) $$$_$$$propertiesNamesMappings
{
    static NSDictionary *_$$$_$$$propertiesNamesMappings=nil; 

        if(_$$$_$$$propertiesNamesMappings==nil) {
    
        _$$$_$$$propertiesNamesMappings=[[NSDictionary alloc] initWithObjectsAndKeys:  @"EventId", @"eventId", @"EventStartTime", @"eventStartTime", @"EventEndTime", @"eventEndTime", @"ChangeKey", @"changeKey", @"EventSubject", @"eventSubject", @"EventLocation", @"eventLocation", @"EventWebLink", @"eventWebLink", @"ReminderFireTime", @"reminderFireTime", nil];
        
    }
    
    return _$$$_$$$propertiesNamesMappings;
}


- (instancetype)init {

	if (self = [super init]) {

		_odataType = @"#Microsoft.OutlookServices.Reminder";

    }

	return self;
}


- (instancetype) initWithDictionary: (NSDictionary *) dic {
    if((self = [self init])) {
        if(dic!=nil) {
		_eventId = (![dic objectForKey: @"EventId"] || [ [dic objectForKey: @"EventId"] isKindOfClass:[NSNull class]] )?_eventId:[[dic objectForKey: @"EventId"] copy];
		_eventStartTime = (![dic objectForKey: @"EventStartTime"] || [ [dic objectForKey: @"EventStartTime"] isKindOfClass:[NSNull class]] )?_eventStartTime:[[MSOutlookDateTimeTimeZone alloc] initWithDictionary: [dic objectForKey: @"EventStartTime"]];
		_eventEndTime = (![dic objectForKey: @"EventEndTime"] || [ [dic objectForKey: @"EventEndTime"] isKindOfClass:[NSNull class]] )?_eventEndTime:[[MSOutlookDateTimeTimeZone alloc] initWithDictionary: [dic objectForKey: @"EventEndTime"]];
		_changeKey = (![dic objectForKey: @"ChangeKey"] || [ [dic objectForKey: @"ChangeKey"] isKindOfClass:[NSNull class]] )?_changeKey:[[dic objectForKey: @"ChangeKey"] copy];
		_eventSubject = (![dic objectForKey: @"EventSubject"] || [ [dic objectForKey: @"EventSubject"] isKindOfClass:[NSNull class]] )?_eventSubject:[[dic objectForKey: @"EventSubject"] copy];
		_eventLocation = (![dic objectForKey: @"EventLocation"] || [ [dic objectForKey: @"EventLocation"] isKindOfClass:[NSNull class]] )?_eventLocation:[[MSOutlookLocation alloc] initWithDictionary: [dic objectForKey: @"EventLocation"]];
		_eventWebLink = (![dic objectForKey: @"EventWebLink"] || [ [dic objectForKey: @"EventWebLink"] isKindOfClass:[NSNull class]] )?_eventWebLink:[[dic objectForKey: @"EventWebLink"] copy];
		_reminderFireTime = (![dic objectForKey: @"ReminderFireTime"] || [ [dic objectForKey: @"ReminderFireTime"] isKindOfClass:[NSNull class]] )?_reminderFireTime:[[MSOutlookDateTimeTimeZone alloc] initWithDictionary: [dic objectForKey: @"ReminderFireTime"]];
    }
    [self.updatedValues removeAllObjects];
    }
    
    return self;
}

- (NSDictionary *) toDictionary {
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];

	{id curVal = [self.eventId copy];if (curVal!=nil) [dic setValue: curVal forKey: @"EventId"];}
	{id curVal = [self.eventStartTime toDictionary];if (curVal!=nil) [dic setValue: curVal forKey: @"EventStartTime"];}
	{id curVal = [self.eventEndTime toDictionary];if (curVal!=nil) [dic setValue: curVal forKey: @"EventEndTime"];}
	{id curVal = [self.changeKey copy];if (curVal!=nil) [dic setValue: curVal forKey: @"ChangeKey"];}
	{id curVal = [self.eventSubject copy];if (curVal!=nil) [dic setValue: curVal forKey: @"EventSubject"];}
	{id curVal = [self.eventLocation toDictionary];if (curVal!=nil) [dic setValue: curVal forKey: @"EventLocation"];}
	{id curVal = [self.eventWebLink copy];if (curVal!=nil) [dic setValue: curVal forKey: @"EventWebLink"];}
	{id curVal = [self.reminderFireTime toDictionary];if (curVal!=nil) [dic setValue: curVal forKey: @"ReminderFireTime"];}
    [dic setValue: @"#Microsoft.OutlookServices.Reminder" forKey: @"@odata.type"];

    return dic;
}

- (NSDictionary *) toUpdatedValuesDictionary {
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];

	{id curVal = self.eventId;
    if([self.updatedValues containsObject:@"EventId"])
    {
                [dic setValue: curVal==nil?[NSNull null]:[curVal copy] forKey: @"EventId"];
            }
    }
	{id curVal = self.eventStartTime;
    if([self.updatedValues containsObject:@"EventStartTime"])
    {
                [dic setValue: curVal==nil?[NSNull null]:[curVal toDictionary] forKey: @"EventStartTime"];
            }
        else
    {
                
        NSDictionary *updatedDic=[curVal toUpdatedValuesDictionary];
        
            if(updatedDic!=nil && [updatedDic count]>0)
            {
                [dic setValue: [curVal toDictionary] forKey: @"EventStartTime"];
            }
        
            }}
	{id curVal = self.eventEndTime;
    if([self.updatedValues containsObject:@"EventEndTime"])
    {
                [dic setValue: curVal==nil?[NSNull null]:[curVal toDictionary] forKey: @"EventEndTime"];
            }
        else
    {
                
        NSDictionary *updatedDic=[curVal toUpdatedValuesDictionary];
        
            if(updatedDic!=nil && [updatedDic count]>0)
            {
                [dic setValue: [curVal toDictionary] forKey: @"EventEndTime"];
            }
        
            }}
	{id curVal = self.changeKey;
    if([self.updatedValues containsObject:@"ChangeKey"])
    {
                [dic setValue: curVal==nil?[NSNull null]:[curVal copy] forKey: @"ChangeKey"];
            }
    }
	{id curVal = self.eventSubject;
    if([self.updatedValues containsObject:@"EventSubject"])
    {
                [dic setValue: curVal==nil?[NSNull null]:[curVal copy] forKey: @"EventSubject"];
            }
    }
	{id curVal = self.eventLocation;
    if([self.updatedValues containsObject:@"EventLocation"])
    {
                [dic setValue: curVal==nil?[NSNull null]:[curVal toDictionary] forKey: @"EventLocation"];
            }
        else
    {
                
        NSDictionary *updatedDic=[curVal toUpdatedValuesDictionary];
        
            if(updatedDic!=nil && [updatedDic count]>0)
            {
                [dic setValue: [curVal toDictionary] forKey: @"EventLocation"];
            }
        
            }}
	{id curVal = self.eventWebLink;
    if([self.updatedValues containsObject:@"EventWebLink"])
    {
                [dic setValue: curVal==nil?[NSNull null]:[curVal copy] forKey: @"EventWebLink"];
            }
    }
	{id curVal = self.reminderFireTime;
    if([self.updatedValues containsObject:@"ReminderFireTime"])
    {
                [dic setValue: curVal==nil?[NSNull null]:[curVal toDictionary] forKey: @"ReminderFireTime"];
            }
        else
    {
                
        NSDictionary *updatedDic=[curVal toUpdatedValuesDictionary];
        
            if(updatedDic!=nil && [updatedDic count]>0)
            {
                [dic setValue: [curVal toDictionary] forKey: @"ReminderFireTime"];
            }
        
            }}
    return dic;
}


/** Setter implementation for property eventId
 *
 */
- (void) setEventId: (NSString *) value {
    _eventId = value;
    [self valueChangedFor:@"EventId"];
}
       
/** Setter implementation for property eventStartTime
 *
 */
- (void) setEventStartTime: (MSOutlookDateTimeTimeZone *) value {
    _eventStartTime = value;
    [self valueChangedFor:@"EventStartTime"];
}
       
/** Setter implementation for property eventEndTime
 *
 */
- (void) setEventEndTime: (MSOutlookDateTimeTimeZone *) value {
    _eventEndTime = value;
    [self valueChangedFor:@"EventEndTime"];
}
       
/** Setter implementation for property changeKey
 *
 */
- (void) setChangeKey: (NSString *) value {
    _changeKey = value;
    [self valueChangedFor:@"ChangeKey"];
}
       
/** Setter implementation for property eventSubject
 *
 */
- (void) setEventSubject: (NSString *) value {
    _eventSubject = value;
    [self valueChangedFor:@"EventSubject"];
}
       
/** Setter implementation for property eventLocation
 *
 */
- (void) setEventLocation: (MSOutlookLocation *) value {
    _eventLocation = value;
    [self valueChangedFor:@"EventLocation"];
}
       
/** Setter implementation for property eventWebLink
 *
 */
- (void) setEventWebLink: (NSString *) value {
    _eventWebLink = value;
    [self valueChangedFor:@"EventWebLink"];
}
       
/** Setter implementation for property reminderFireTime
 *
 */
- (void) setReminderFireTime: (MSOutlookDateTimeTimeZone *) value {
    _reminderFireTime = value;
    [self valueChangedFor:@"ReminderFireTime"];
}
       

@end
