#import "MyCommandView.h"

@implementation MyCommandView
-(void)insertHistoryCommand
{
	NSUInteger					start,end;
	int							i;
	NSMutableAttributedString	*s=[self textStorage];
	NSMutableString				*cmd;
	NSArray						*cmdArray;
	
	[[s mutableString] getLineStart:&start end:&end contentsEnd:nil forRange:(NSRange){[s length]-1,1}];
	[s deleteCharactersInRange:(NSRange){start,end-start}];
	
	cmdArray=[history objectAtIndex:[history count]-1-ihist];
	
	cmd=[NSMutableString stringWithFormat:@"> %@",[cmdArray objectAtIndex:0]];
	if([cmdArray count]>1)
		[cmd appendString:@"("];
	for(i=1;i<[cmdArray count];i++)
	{
		[cmd appendString:[cmdArray objectAtIndex:i]];
		if(i<[cmdArray count]-1)
			[cmd appendString:@","];
		else
			[cmd appendString:@")"];
	}

	[self insertText:cmd];
}
-(void)keyDown:(NSEvent*)e
{
	if([e keyCode]==76||[e keyCode]==36)
	{
		if([e isARepeat]==NO)
		{
			NSString		*s=[self string],*t;
			int				n;
			NSUInteger		start;
			NSMutableArray	*theCmd=[NSMutableArray new];
			
			[s getLineStart:&start end:nil contentsEnd:nil forRange:(NSRange){[s length]-1,1}];
			s=[s substringWithRange:(NSRange){start+2,[s length]-start-2}];
			NSScanner		*scn=[NSScanner scannerWithString:s];
			NSCharacterSet	*charSet=[NSCharacterSet characterSetWithCharactersInString:@"(,)"];
			while ([scn isAtEnd] == NO)
			{
				n=[scn scanUpToCharactersFromSet:charSet intoString:&t];
				if(n)
					[theCmd addObject:t];
				if([scn isAtEnd] ==NO)
					[scn setScanLocation:[scn scanLocation]+1];
			}
			[app applyCmd:theCmd];
			[history addObject:theCmd];
			[theCmd release];
		}
		[self setSelectedRange:(NSRange){[[self string] length],1}];
		[self insertText:@"\r> "];
	}
	else
	if([e keyCode]==125)
	{
		ihist--;
		if(ihist<0)
			ihist=0;
		[self insertHistoryCommand];
	}
	else
	if([e keyCode]==126)
	{

		if(ihist>=[history count])
			ihist--;
		[self insertHistoryCommand];
		ihist++;
	}
	else
	{
		[super keyDown:e];
		ihist=0;
	}
}
#pragma mark -
-(void)setApp:(id)theApp
{
	app=theApp;
	history=[NSMutableArray	new];
	ihist=0;
}
@end
