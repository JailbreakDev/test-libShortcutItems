include theos/makefiles/common.mk

TWEAK_NAME = anothertestwedo
anothertestwedo_FILES = Tweak.xm
anothertestwedo_LIBRARIES = ShortcutItems

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
