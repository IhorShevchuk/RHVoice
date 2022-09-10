//
//  ViewController.swift
//  macOSSample
//
//  Created by Ihor Shevchuk on 21.05.2022.
//

import Cocoa
import RHVoice

class ViewController: NSViewController {
    
    var synthesizer: RHSpeechSynthesizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        synthesizer = RHSpeechSynthesizer()
        let voice = RHSpeechSynthesisVoice.speechVoices().first
        let utterance = RHSpeechUtterance(text: "Sample Text")
        if let voice = voice {
            utterance.voice = voice
        }
        synthesizer?.speak(utterance)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

