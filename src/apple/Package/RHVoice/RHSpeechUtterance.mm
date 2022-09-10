//
//  RHSpeechUtterance.m
//  RHVoice
//
//  Created by Ihor Shevchuk on 03.05.2022.
//
//  Copyright (C) 2022  Olga Yakovleva <olga@rhvoice.org>

#import <RHVoice/RHSpeechUtterance.h>

#import "RHVoiceBridge+PrivateAdditions.h"
#include "RHSpeechUtterance+Private.h"
#include "RHSpeechSynthesisVoice+Private.h"

@interface RHSpeechUtterance()
@end

@implementation RHSpeechUtterance

- (instancetype)init {
    return [self initWithText:nil];
}

- (instancetype)initWithText:(NSString * _Nullable)text {
    
    NSString *textInternal = text;
    if(textInternal == nil) {
        textInternal = @"";
    }
    
    return [self initWithSSML:[NSString stringWithFormat:@"<speak>%@</speak>", textInternal]];;
}

- (instancetype)initWithSSML:(NSString * _Nullable)ssml {
    self = [super init];
    if(self) {
        _ssml = ssml;
        self.rate = 1.0;
        self.volume = 1.0;
        self.quality = RHSpeechUtteranceQualityStandart;
        self.voice = [[RHSpeechSynthesisVoice speechVoices] firstObject];
    }
    return self;
}

- (BOOL)isEmpty {
    return self.ssml.length == 0 || self.ssml == nil || [self.ssml isEqualToString:@"<speak></speak>"];
}

#pragma mark - Privates

- (RHVoice::voice_list::const_iterator)voiceInfo {
    return self.voice.voiceInfo;
}

- (RHVoice::quality_t)rhVoiceQuality {
    switch (self.quality) {
        case RHSpeechUtteranceQualityMin:
            return RHVoice::quality_t::quality_min;
        case RHSpeechUtteranceQualityStandart:
            return RHVoice::quality_t::quality_std;
        case RHSpeechUtteranceQualityMax:
            return RHVoice::quality_t::quality_max;
        default:
            return RHVoice::quality_t::quality_std;
    }
}

- (std::unique_ptr<RHVoice::document>)rhVoiceDocument {
    std::unique_ptr<RHVoice::document> doc;
    
    RHVoice::voice_profile voiceProfile(self.voiceInfo);
    
    /// Using wsting or any other utf16 string is causing huge memory usage that is much bigger than 60 MB that is a limit for app extention
    std::string textToSpeak = self.ssml.UTF8String;
    doc = RHVoice::document::create_from_ssml([RHVoiceBridge sharedInstance].engine,
                                     textToSpeak.begin(),
                                     textToSpeak.end(),
                                     voiceProfile);
    doc->speech_settings.relative.rate = self.rate;
    doc->speech_settings.relative.volume = self.volume;
    doc->quality = self.rhVoiceQuality;
    
    return doc;
}
@end
