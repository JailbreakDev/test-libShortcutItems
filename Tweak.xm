#import <libShortcutItems/libShortcutItems.h>

%ctor {
	NSString *processName = [[NSProcessInfo processInfo] processName];
	if ([processName isEqualToString:@"SpringBoard"]) {
		if ([LSIManager sharedManager].isRunningInsideSpringBoard) {
			LSISBSApplicationShortcutItem *item = [[LSIManager sharedManager] newShortcutItemType:@"test_icon" title:@"Test" subtitle:@"Testing libShortcutItems" iconType:UIApplicationShortcutIconTypeAdd];
		    [[LSIManager sharedManager] addShortcutItems:@[item] toApplicationID:@"com.apple.Preferences"];
		    LSISBSApplicationShortcutItem *sbItem = [[LSIManager sharedManager] newShortcutItemType:@"test_sb_icon" title:@"Test" subtitle:@"Testing SpringBoard" iconType:UIApplicationShortcutIconTypeAdd];
		    [sbItem setHandledBySpringBoard:YES];
		    [[LSIManager sharedManager] addShortcutItems:@[sbItem] toApplicationID:@"com.apple.iBooks"];
		    [[LSIManager sharedManager] setSBShortcutHandlerBlock:^(LSISBSApplicationShortcutItem *item) {
		    	NSLog(@"Handled %@ on SpringBoard",item.localizedTitle);
		    }];
		}
	} else if ([processName isEqualToString:@"Preferences"]) {
		[[LSIManager sharedManager] setShortcutHandlerBlock:^(UIApplicationShortcutItem *item) {
			dispatch_async(dispatch_get_main_queue(),^{
				UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Test" message:@"Worked" preferredStyle:UIAlertControllerStyleAlert];
			    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
			    [[[UIApplication sharedApplication].keyWindow rootViewController] presentViewController:alert animated:YES completion:nil];
			});
		}];
	}
}
