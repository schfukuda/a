# ビルドに使用するターゲットSDKを指定
TARGET = iphone:clang:latest:15.0

# プロジェクト名
TWEAK_NAME = MixEverywhere

# リンクするフレームワークを指定
$(TWEAK_NAME)_FRAMEWORKS = UIKit AVFoundation

# Tweakのソースファイルを指定
$(TWEAK_NAME)_FILES = Tweak.xm

# Theosの共通Makefileを読み込み
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/library.mk
