@protocol MyDocument
-(NSObjectController*)settings;
-(NSArray*)cmds;
-(void)applyCmd:(NSArray*)theCmd;
-(NSString*)path;
-(void)configureInterface;
@end
