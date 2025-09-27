TARGET := iphone:clang:latest:7.0


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ev

ev_FILES = Tweak.x
ev_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
