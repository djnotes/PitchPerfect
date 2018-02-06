//
//  ViewController.swift
//  PitchPerfect
//
//  Created by John Doe on 20/01/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var recordingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "در حال ضبط..."
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordingLabel.text = "ضبط متوقف شد"
    }
}

