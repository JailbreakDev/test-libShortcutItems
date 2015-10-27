#import <libShortcutItems/libShortcutItems.h>

%ctor {
	NSString *processName = [[NSProcessInfo processInfo] processName];
	if ([processName isEqualToString:@"SpringBoard"]) {
		if ([LSIManager sharedManager].isRunningInsideSpringBoard) {
			LSIApplicationShortcutItem *testItem = [LSIApplicationShortcutItem newShortcutItemType:@"test_icon" title:@"Test" subtitle:@"Testing libShortcutItems" iconType:UIApplicationShortcutIconTypeAdd];
			LSIApplicationShortcutItem *test2Item = [LSIApplicationShortcutItem newShortcutItemType:@"test2_icon" title:@"Test2" subtitle:@"Testing again" iconType:UIApplicationShortcutIconTypePlay];
			LSICallback *callback = [LSICallback callbackWithBlock:^(LSIApplicationShortcutItem *item) {
				NSLog(@"Handled %@ on SpringBoard",item.localizedTitle);
			}];
			[testItem setCallback:callback];
			[[LSIManager sharedManager] addShortcutItems:@[testItem,test2Item] toApplicationID:@"com.apple.Preferences"];
		}
	} else if ([processName isEqualToString:@"Preferences"]) {
		[[LSIManager sharedManager] addCallback:[LSICallback callbackWithBlock:^(LSIApplicationShortcutItem *item) {
			NSLog(@"Handled %@ in Preferences",item.localizedTitle);
		}]];
	}
}
