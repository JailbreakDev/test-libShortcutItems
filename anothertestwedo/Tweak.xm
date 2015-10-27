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
			if ([item.type isEqualToString:@"test3_icon"]) {
				NSLog(@"Handled %@ in Preferences",item.localizedTitle);
			}
		}]];
	}
}
