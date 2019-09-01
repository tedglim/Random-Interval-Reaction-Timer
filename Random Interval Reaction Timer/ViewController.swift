//
//  ViewController.swift
//  Random Interval Reaction Timer
//
//  Created by Ted Ganting Lim on 8/23/19.
//  Copyright © 2019 Jobless. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,
UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerPicker: UIPickerView!
    @IBOutlet weak var coverTimerPicker: UIView!
    @IBOutlet weak var startPauseResumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var coverSettings: UIView!
    @IBOutlet weak var settings: UIView!
    @IBOutlet weak var buttons: UIView!
    
    var mainSoundsArray = [URL]()
    var soundsArray = [URL]()
    var soundPlayer = AVAudioPlayer()
    var colorArray = [UIColor.red, UIColor.blue, UIColor.purple, UIColor.cyan, UIColor.orange]
    var prevAudio = URL(string: "")
    var prevColor = UIColor.white
    let timerPickerCol01 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 29, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60]
    let timerPickerCol02 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 29, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60]
    var selectedTime01 = 0
    var selectedTime02 = 0
    var totalSeconds = 0
    var countdownTimer: Timer!
    var elapsedTime = 0
    var currTime = 0
    var canStartState = true
    var canPauseState = false
    var canResumeState = false
    var elapsedIntervalOfTime = 0
    var minIntervalAmount = 2
    
    var passedOptions = [SettingsTableViewController.Options]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        mainSoundsArray = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: "Sounds")!
//        for sound in soundsArray {
//            print(sound)
//        }
        coverTimerPicker.isHidden = true
        self.timerPicker.delegate = self
        self.timerPicker.dataSource = self
        
    }

    //randomly choose files to play from settings-based audio file array
    func playRandomAudio(selectedAudio: [URL]) {
        if selectedAudio.count == 1 {
            do {
                soundPlayer = try AVAudioPlayer(contentsOf: selectedAudio[0])
                soundPlayer.volume = 1
                soundPlayer.play()
            } catch {
                print(error)
            }
        } else {
            var audioChoices = selectedAudio
            if prevAudio != URL(string: "") {
                if let index = audioChoices.firstIndex(of: prevAudio!) {
                    audioChoices.remove(at: index)
                }
            }
            let selection = Int.random(in: 0...(audioChoices.count-1))
            do {
                soundPlayer = try AVAudioPlayer(contentsOf: audioChoices[selection])
                soundPlayer.volume = 1
                soundPlayer.play()
                prevAudio = audioChoices[selection]
            } catch {
                print(error)
            }
        }
    }
    
    //randomly choose foreground color of app
    func changeForegroundColor(selectedColors: [UIColor]) {
        if selectedColors.count == 1 {
            coverTimerPicker.backgroundColor = selectedColors[0]
            coverSettings.backgroundColor = selectedColors[0]
            buttons.backgroundColor = selectedColors[0]
        } else {
            var colorChoices = selectedColors
            if prevColor != UIColor.white {
                if let index = colorChoices.firstIndex(of: prevColor) {
                    colorChoices.remove(at: index)
                }
            }
            let selection = Int.random(in: 0...(colorChoices.count-1))
            let chosenColor = colorChoices[selection]
            coverTimerPicker.backgroundColor = chosenColor
            coverSettings.backgroundColor = chosenColor
            buttons.backgroundColor = chosenColor
            prevColor = chosenColor
        }
    }
    
    //Table Setup
    //number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // Set number of rows of each column to length of arrays
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0:
                return self.timerPickerCol01.count
            case 1:
                return self.timerPickerCol02.count
            default: return -1
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            let str = String(self.timerPickerCol01[row])
            return str
        case 1:
            let str = String(self.timerPickerCol01[row])
            return str
        default: return ""
        }
    }
    
    // This method colors text in picker view
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0:
            let tempString = String(self.timerPickerCol01[row])
            let coloredText = NSAttributedString(string: tempString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            return coloredText
        case 1:
            let tempString = String(self.timerPickerCol01[row])
            let coloredText = NSAttributedString(string: tempString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            return coloredText
        default: return NSMutableAttributedString()
        }
    }
    
    // This method is triggered whenever the user makes a change to the picker selection.
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedTime01 = self.timerPickerCol01[row]
        case 1:
            selectedTime02 = self.timerPickerCol02[row]
        default:
            break
        }
        totalSeconds = selectedTime01 * 60 + selectedTime02
    }

    
    //Timer Setup
    //starts Timer
    func startTimer() {
        soundsArray = setupSounds()
        colorArray = setupColors()
        totalSeconds = selectedTime01 * 60 + selectedTime02
        canStartState = false
        canPauseState = true
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func setupSounds () -> [URL] {
        var sounds = [URL]()
        var count = 0
        for option in passedOptions {
            if option.isSound {
                count = count + 1
                for url in mainSoundsArray {
                    if (url.absoluteString.range(of: option.text) != nil) {
                        sounds.append(url)
                    }
                }
            }
        }
        print("Printed sounds: \(sounds)")
        print(count)
        return sounds
    }
    
    func setupColors() -> [UIColor] {
        var colors = [UIColor]()
        for option in passedOptions {
            if option.isColor {
                if (option.text == "red") {
                    colors.append(UIColor.red)
                } else if (option.text == "blue") {
                    colors.append(UIColor.blue)
                } else if (option.text == "purple") {
                    colors.append(UIColor.purple)
                } else if (option.text == "cyan") {
                    colors.append(UIColor.cyan)
                } else if (option.text == "orange") {
                    colors.append(UIColor.orange)
                }
            }
        }
        return colors
    }
    
    //updates timer; checks when to trigger stimulus
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalSeconds))"
        if totalSeconds != -1 {
            totalSeconds -= 1
            if canTriggerStimulus() {
                if (soundsArray.count > 0) {
                    self.playRandomAudio(selectedAudio: soundsArray)
                }
                if (colorArray.count > 0) {
                    self.changeForegroundColor(selectedColors: colorArray)
                }
                print("stimulus triggered")
            }
        } else {
            self.endTimer()
        }
    }
    
    //formats time to 00:00
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
        
    }
    
    //checks if elapsed time meets a min condition (>2s), then 1/2* chance to trigger stimulus
    func canTriggerStimulus () -> Bool {
        elapsedIntervalOfTime += 1
        if elapsedIntervalOfTime > minIntervalAmount {
            let num = Int.random(in: 0...1)
            if num == 0 {
                elapsedIntervalOfTime = 0
                return true
            }
        }
        return false
    }
    
    //resets labels, timer, views and states to starting conditions
    func endTimer() {
        if (countdownTimer != nil) {
            countdownTimer.invalidate()
            coverTimerPicker.isHidden = true
            coverSettings.isHidden = true
            settings.isHidden = false
            timerPicker.isHidden = false
            minutesLabel.isHidden = false
            secondsLabel.isHidden = false
            startPauseResumeButton.setTitle("Start", for: .normal)
            canStartState = true
            canPauseState = false
            canResumeState = false
            coverTimerPicker.backgroundColor = UIColor.black
            coverSettings.backgroundColor = UIColor.black
            buttons.backgroundColor = UIColor.black
        }
    }
    
    //controls Start/Pause/Resume states
    @IBAction func hitStart(sender: UIButton)
    {
        if canStartState {
            minutesLabel.isHidden = true
            secondsLabel.isHidden = true
            coverTimerPicker.isHidden = false
            timerPicker.isHidden = true
            coverSettings.isHidden = false
            settings.isHidden = true
            startTimer()
            startPauseResumeButton.setTitle("Pause", for: .normal)
        } else if canPauseState {
            canPauseState = false
            canResumeState = true
            countdownTimer.invalidate()
            startPauseResumeButton.setTitle("Resume", for: .normal)
            print("pause")
        } else if canResumeState {
            canPauseState = true
            canResumeState = false
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            startPauseResumeButton.setTitle("Pause", for: .normal)
            print("resume")
        }
    }
    
    //resets timer state
    @IBAction func hitCancel(sender: UIButton)
    {
        endTimer()
        print("Cancel")
        
    }
    
    //segues to Settings
    @IBAction func hitSettings(sender: UIButton)
    {
        performSegue(withIdentifier: "segueToSettings", sender: self)
        print("Settings")
        print(passedOptions)
    }
    
    //unwindSegues to main view
    @IBAction func cancelToViewController(_ unwindSegue: UIStoryboardSegue)
    {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSettings" {
            print("segue to settings")
            let nc = segue.destination as! UINavigationController
            let tableVC = nc.viewControllers.first as! SettingsTableViewController
            tableVC.selectedOptions = passedOptions
        }
    }
}
