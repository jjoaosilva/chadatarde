//
//  TimerTeaViewController.swift
//  ChaDaTarde
//
//  Created by Jose Joao Silva Nunes Alves on 18/04/20.
//  Copyright © 2020 Jose Joao Silva Nunes Alves. All rights reserved.
//ver vplay

import UIKit

class TimerTeaViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var goInfusion: UIButton!
    @IBOutlet weak var stopInfusion: UIButton!
    
    var seconds : Int = Int() {
        didSet {
            self.timerLabel.text = timeString(time: TimeInterval(36))
        }
    }
    
    let inicialTime = 5
    var timer = Timer()
    var isTimerRunning = false
    
    var handleColorAnimation = true
    var timerFinishAnimation = Timer()
    let repeatsMax : Int = 5
    var repeatsCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seconds = inicialTime
        timerLabel.text = timeString(time: TimeInterval(seconds))
        
        goInfusion.layer.cornerRadius = 10
        stopInfusion.layer.cornerRadius = 10
        stopInfusion.setTitle("Reiniciar", for: .normal)
        
        pauseComportamentInterface()
    }

    @IBAction func goInfusionTapped(_ sender: UIButton) {
        if !isTimerRunning {
            runTimer()
            isTimerRunning = true
            playComportamentInterface()
        } else{
            timer.invalidate()
            isTimerRunning = false
            pauseComportamentInterface()
        }
    }
    
    @IBAction func stopInfusionTapped(_ sender: UIButton) {
        restart()
    }
    
    @IBAction func configTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ConfigModal", sender: nil)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigation = segue.destination as! UINavigationController
        let controller = navigation.topViewController as! ConfugurationsViewController
        controller.delegate = self
    }
    
    func pauseComportamentInterface() {
        goInfusion.setTitle("Infusionar!", for: .normal)
        goInfusion.setImage(UIImage(systemName: "play"), for: .normal)
        
        timerLabel.textColor = UIColor.systemGray
    }
    
    func playComportamentInterface() {
        goInfusion.setTitle("Pausar", for: .normal)
        goInfusion.setImage(UIImage(systemName: "pause"), for: .normal)
    
        timerLabel.textColor = UIColor(228, 100, 54, 1)
    }
    
    func restart() {
        seconds = inicialTime
        repeatsCount = 0
        handleColorAnimation = true
        isTimerRunning = false
        
        timerLabel.text = timeString(time: TimeInterval(seconds))
        
        timer.invalidate()
        timerFinishAnimation.invalidate()
        
        pauseComportamentInterface()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func timeFinish() {
        timerFinishAnimation = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleColor), userInfo: nil, repeats: true)
    }
    
    @objc func handleColor() {
        timerLabel.textColor = handleColorAnimation ? UIColor.systemGray : UIColor(228, 100, 54, 1)
        handleColorAnimation = !handleColorAnimation
        repeatsCount += 1
        if repeatsCount == repeatsMax {
            restart()
        }
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            timeFinish()
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time)/60 % 60
        let seconds = Int(time) % 60

        return String(format: "%02i:%02i", minutes, seconds)
    }
}

extension UIColor{
    convenience init(_ redInt: Float, _ greenInt: Float, _ blueInt: Float,_ alphaInt: Float){
        self.init(red: CGFloat(redInt/255), green: CGFloat(greenInt/255), blue: CGFloat(blueInt/255), alpha: CGFloat(alphaInt))
    }
}

protocol SettingsDelegate: class {
    func didSetTimer(seconds: Int, name: String)
}

extension TimerTeaViewController : SettingsDelegate {
    func didSetTimer(seconds: Int, name: String){
        print(seconds)
        self.seconds = seconds
    }
}
