export ARCHS = armv7 arm64
export TARGET = iphone:clang:9.0
include theos/makefiles/common.mk

TWEAK_NAME = TestLibShortcutItems
TestLibShortcutItems_FILES = Tweak.xm
TestLibShortcutItems_LIBRARIES = ShortcutItems
TestLibShortcutItems_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += anothertestwedo
include $(THEOS_MAKE_PATH)/aggregate.mk
