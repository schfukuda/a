#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

%hook AVAudioSession

// --- setActive:withOptions:error: ---
-(BOOL)setActive:(BOOL)active withOptions:(AVAudioSessionCategoryOptions)options error:(NSError **)outError {
    if (active) {
        AVAudioSessionCategoryOptions currentOptions = self.categoryOptions;
        if (!(currentOptions & AVAudioSessionCategoryOptionMixWithOthers)) {
            AVAudioSessionCategoryOptions newOptions = currentOptions | AVAudioSessionCategoryOptionMixWithOthers;
            NSLog(@"[MixEverywhere] Hooked setActive. Forcing mixWithOthers. Options: %llu -> %llu", (unsigned long long)currentOptions, (unsigned long long)newOptions);
            NSError *setError = nil;
            [self setCategory:self.category withOptions:newOptions error:&setError];
            if (setError) {
                NSLog(@"[MixEverywhere] Error forcing category via setActive: %@", setError);
            }
        }
    }
    return %orig(active, options, outError);
}

// --- setActive:error: (legacy) ---
-(BOOL)setActive:(BOOL)active error:(NSError **)outError {
    if (active) {
        AVAudioSessionCategoryOptions currentOptions = self.categoryOptions;
        if (!(currentOptions & AVAudioSessionCategoryOptionMixWithOthers)) {
            AVAudioSessionCategoryOptions newOptions = currentOptions | AVAudioSessionCategoryOptionMixWithOthers;
            NSLog(@"[MixEverywhere] Hooked setActive (legacy). Forcing mixWithOthers. Options: %llu -> %llu", (unsigned long long)currentOptions, (unsigned long long)newOptions);
            NSError *setError = nil;
            [self setCategory:self.category withOptions:newOptions error:&setError];
            if (setError) {
                NSLog(@"[MixEverywhere] Error forcing category via setActive (legacy): %@", setError);
            }
        }
    }
    return %orig(active, outError);
}

// --- setCategory:withOptions:error: ---
-(BOOL)setCategory:(NSString *)category withOptions:(AVAudioSessionCategoryOptions)options error:(NSError **)outError {
    AVAudioSessionCategoryOptions newOptions = options | AVAudioSessionCategoryOptionMixWithOthers;
    return %orig(category, newOptions, outError);
}

%end