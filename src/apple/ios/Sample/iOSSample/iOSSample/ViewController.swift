//
//  ViewController.swift
//  iOSSample
//
//  Created by Ihor Shevchuk on 21.05.2022.
//

import UIKit
import RHVoice

class ViewController: UIViewController {
    
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
}

