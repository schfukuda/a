#import <AVFoundation/AVFoundation.h>

%hook AVAudioSession

// アプリがオーディオセッションのカテゴリを設定するメソッドに割り込む
-(BOOL)setCategory:(NSString *)category withOptions:(AVAudioSessionCategoryOptions)options error:(NSError **)outError {
    // 元のオプションに 'mixWithOthers' を強制的に追加
    AVAudioSessionCategoryOptions newOptions = options | AVAudioSessionCategoryOptionMixWithOthers;
    // デバッグ用のログを出力
    NSLog(@"[MixEverywhere] Hooked setCategory. Original options: %lu, New options: %lu", (unsigned long long)options, (unsigned long long)newOptions);
    // 改変したオプションで、元のメソッドを呼び出す
    return %orig(category, newOptions, outError);
}

%end
