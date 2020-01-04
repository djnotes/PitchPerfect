//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by John Doe on 20/01/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording..."
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let fileName = "my_voice.wav"
        let pathArray = [dirPath, fileName]
        let filePath = URL(string: pathArray.joined(separator:  "/"))
        
        print(filePath?.absoluteString as Any)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord), with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()

        
        stopRecordingButton.isEnabled = true
    }
    
    @IBAction func  stopRecording(_ sender: Any) {
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        recordingLabel.text = "Tap to Record"
        //Stop recording
        audioRecorder.stop();
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        print("stopRecording called")
    }
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
        print ("Recording failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecording") {
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
