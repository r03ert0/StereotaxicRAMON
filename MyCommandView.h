/* MyTextView */

#import <Cocoa/Cocoa.h>
#import "MyDocumentProtocol.h"

@interface MyCommandView : NSTextView
{
	NSMutableArray	*history;
	int				ihist;

	id<MyDocument>	app;
}
-(void)setApp:(id)theApp;
@end
