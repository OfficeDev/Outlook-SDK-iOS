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



#ifndef MSOUTLOOKITEMFETCHER_H
#define MSOUTLOOKITEMFETCHER_H

#import "MSOutlookModels.h"
#import "api/api.h"
#import "core/core.h"
#import "core/MSOrcEntityFetcher.h"

@class MSOutlookMessageFetcher;	
@class MSOutlookEventFetcher;	
@class MSOutlookContactFetcher;	
@class MSOutlookPostFetcher;	
@class MSOutlookItemOperations;


/** MSOutlookItemFetcher
 *
 */
@interface MSOutlookItemFetcher : MSOrcEntityFetcher

@property (copy, nonatomic, readonly) MSOutlookItemOperations *operations;

- (instancetype)initWithUrl:(NSString*)urlComponent parent:(id<MSOrcExecutable>)parent;
- (void)readWithCallback:(void (^)(MSOutlookItem *, MSOrcError *))callback;
- (void)update:(MSOutlookItem *)Item callback:(void (^)(MSOutlookItem *, MSOrcError*))callback ;
- (void)delete:(void(^)(int status, MSOrcError *))callback;
- (MSOutlookItemFetcher *)addCustomParametersWithName:(NSString *)name value:(id)value;
- (MSOutlookItemFetcher *)addCustomHeaderWithName:(NSString *)name value:(NSString *)value;
- (MSOutlookItemFetcher *)select:(NSString *)params;
- (MSOutlookItemFetcher *)expand:(NSString *)value;
- (MSOutlookMessageFetcher *)asMessage;	
- (MSOutlookEventFetcher *)asEvent;	
- (MSOutlookContactFetcher *)asContact;	
- (MSOutlookPostFetcher *)asPost;	

@end

#endif
