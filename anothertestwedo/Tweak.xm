#import <libShortcutItems/libShortcutItems.h>

%ctor {
	NSString *processName = [[NSProcessInfo processInfo] processName];
	if ([processName isEqualToString:@"SpringBoard"]) {
		if ([LSIManager sharedManager].isRunningInsideSpringBoard) {
			LSIApplicationShortcutItem *testItem = [LSIApplicationShortcutItem newShortcutItemType:@"test3_icon" title:@"Test3" subtitle:@"Third Test" iconType:UIApplicationShortcutIconTypeCompose];
			[[LSIManager sharedManager] addShortcutItem:testItem toApplicationID:@"com.apple.Preferences"];
		}
	} else if ([processName isEqualToString:@"Preferences"]) {
		[[LSIManager sharedManager] addCallback:[LSICallback callbackWithBlock:^(LSIApplicationShortcutItem *item) {
			NSLog(@"Handled %@ in Preferences",item.localizedTitle);
		} forIdentifiers:@[@"test3_icon"]]]; //adding forIdentifiers and specifying an array of your identifiers ensures only your items are send to your callback
	}
}
