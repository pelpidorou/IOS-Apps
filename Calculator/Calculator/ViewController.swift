//
//  ViewController.swift
//  Calculator
//
//  Created by Pavlos Elpidorou on 28/11/2016.
//  Copyright © 2016 Pavlos Elpidorou. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

   
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
           try btnSound = AVAudioPlayer(contentsOf:soundURL as URL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
                print(err.debugDescription)
                print("error is here")
        }
        
    }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
    }
    
        

    @IBAction func onClearPressed(_ sender: Any) {
        playSound()
        outputLabel.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        processOperation(op: Operation.Empty)
    }
    
    
    @IBAction func onDividePressed(_ sender: Any) {
        playSound()
        processOperation(op: Operation.Divide)
    }
    

    
    @IBAction func onMultiplyPressed(_ sender: Any) {
        playSound()
        processOperation(op: Operation.Multiply)
    }
    
    @IBAction func onSubsPressed(_ sender: Any) {
        playSound()
        processOperation(op: Operation.Substract)
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        playSound()
        processOperation(op: Operation.Add)
    }
    
    @IBAction func onEqualsPressed(_ sender: Any) {
        playSound()
        processOperation(op: currentOperation)
    }
    
    func processOperation(op : Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            //run some math
            
            //selected an operator but selected an operator again without first entering a number
            if runningNumber != ""{
                

            rightValStr = runningNumber
            runningNumber = ""
            
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)!  * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if currentOperation == Operation.Substract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputLabel.text = result
                
        }
            
            currentOperation = op
            
        }else{
            //first time running an operation
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
   }

