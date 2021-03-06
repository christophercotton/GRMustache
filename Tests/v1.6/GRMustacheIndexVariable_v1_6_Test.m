// The MIT License
// 
// Copyright (c) 2011 Christopher Cotton
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "GRMustacheIndexVariable_v1_6_Test.h"

@implementation GRMustacheIndexVariable_v1_6_Test

- (void)testBasicIndexVariable {
	NSString *templateString = @"{{#things}}{{-index}}{{/things}}";
	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
						  [NSArray arrayWithObjects:@"foo", @"bar", @"baz", nil], @"things",
						  nil];
	GRMustacheTemplate *template = [GRMustacheTemplate parseString:templateString error:nil];
	NSString *result = [template renderObject:data];
	STAssertEqualObjects(result, @"123", nil);
}

- (void)testIndexVariableOnSingleton {
	NSString *templateString = @"{{#things}}{{-index}}{{/things}}";
	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
						  @"foo", @"things",
						  nil];
	GRMustacheTemplate *template = [GRMustacheTemplate parseString:templateString error:nil];
	NSString *result = [template renderObject:data];
	STAssertEqualObjects(result, @"0", nil);
}

- (void)testIndexVariableWithParent {
	NSString *templateString = @"{{#people}}{{#name}}{{../-index}}{{/name}} {{/people}}";
	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
						  [NSArray arrayWithObjects:
						   [NSDictionary dictionaryWithObjectsAndKeys:@"Alan", @"name", @"1", @"id", nil],
						   [NSDictionary dictionaryWithObjectsAndKeys:@"Roger", @"name", @"2", @"id", nil],
						   nil], @"people",
						  nil
						  ];
	GRMustacheTemplate *template = [GRMustacheTemplate parseString:templateString error:nil];
	NSString *result = [template renderObject:data];
	STAssertEqualObjects(result, @"1 2 ", nil);

}


@end
