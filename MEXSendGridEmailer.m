//
//  MEXSendGridEmailer.m
//

/*
 
 Copyright (c) 2012 Eduardo Almeida
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "MEXSendGridEmailer.h"
#import "NSString+MEXAddons.h"

#define kSendGridUser @""
#define kSendGridKey @""

@implementation MEXSendGridEmailer

- (BOOL)sendEmailWithSubject:(NSString *)subject body:(NSString *)body isHTML:(BOOL)isHTML recipient:(NSString *)recipient name:(NSString *)recpName sender:(NSString *)sender name:(NSString *)sendName {
    NSString *urlString = nil;
    
    if (!isHTML)
        urlString = [[NSString stringWithFormat:@"https://sendgrid.com/api/mail.send.xml?api_user=%@&api_key=%@&to=%@&subject=%@&text=%@&from=%@&fromname=%@&toname=%@", kSendGridUser, kSendGridKey, recipient, subject, body, sender, sendName, recpName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    else
        urlString = [[NSString stringWithFormat:@"https://sendgrid.com/api/mail.send.xml?api_user=%@&api_key=%@&to=%@&subject=%@&html=%@&from=%@&fromname=%@&toname=%@", kSendGridUser, kSendGridKey, recipient, subject, body, sender, sendName, recpName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *response = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
    
    if ([response containsString:@"<message>success</message>"])
        return YES;
    
    return NO;
}

@end
