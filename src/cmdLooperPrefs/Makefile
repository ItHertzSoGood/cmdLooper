include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = cmdLooperPrefs

cmdLooperPrefs_FILES = $(wildcard *.m)
cmdLooperPrefs_INSTALL_PATH = /Library/PreferenceBundles
cmdLooperPrefs_FRAMEWORKS = UIKit
cmdLooperPrefs_PRIVATE_FRAMEWORKS = Preferences OnBoardingKit
cmdLooperPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/cmdLooperPrefs.plist$(ECHO_END)