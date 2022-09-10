
## System requirements

* iOS 13.0 or newer
* macOS 11.0 or newer

## Required tools

To compile RHVoice the following programs must be installed on your system:

* [Xcode](https://developer.apple.com/xcode/) version 14 or newer.

## Get sources

1. One line
    ```bash
    git clone --recursive https://github.com/RHVoice/RHVoice.git
    ```
2. Step by step
    ```bash
    git clone https://github.com/RHVoice/RHVoice.git
    cd RHVoice
    git submodule update --init
    ```

## Compilation

```bash
swift build
```

## Swift Package 

Add Swift Package as dependency
```swift
dependencies: [
    .package(url: "https://github.com/RHVoice/RHVoice.git")
]
```

## Usage


### Add `RHVoice.json`

It is needed to have `RHVoice.json` added to your Xcode project so that RHVoice knows which voices and languages to embed in bundle to be used.
Sample of `RHVoice.json`:
```json
{
    "languages":[
        "English"
    ],
    "voices":[
        "alan"
    ]
}

```

### Add `PackDataPlugin` to be `Build Phases`

In order to automatically copy voices and languages to bundle of your application you need to add `PackDataPlugin` to `Run Build Tool Plug-ins` build phase of your app. It will "build" `RHVoice.json` and as the result you will have `RHVoiceData` folder with voices and languages data embeded to bundle of your application.

### Import RHVoice

```swift
import RHVoice
```

### `RHSpeechSynthesizer`

Create `RHSpeechSynthesizer` instance
```swift
let synthesizer = RHSpeechSynthesizer()
```
It is needed to retain `synthesizer` while it is "speaking"

### Select needed voice

```swift
let voice = RHSpeechSynthesisVoice.speechVoices().first { voice in
    return voice.language.code == "us" && voice.gender == RHSpeechSynthesisVoiceGenderMale
}
```

### `RHSpeechUtterance` 
Create `RHSpeechUtterance` with required text to speak assign voice and let it speek using `synthesizer`
```swift
let utterance = RHSpeechUtterance(text: "Sample Text")
utterance.voice = voice
synthesizer.speak(utterance)
```
### Samples

Please refer to samples for more details
 1. [iOS](/src/apple/ios/Sample/iOSSample)
 2. [macOS](/src/apple/macOS/Sample/macOSSample)
