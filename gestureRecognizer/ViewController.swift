//
//  ViewController.swift
//  gestureRecognizer
//
//  Created by Jaime_Andrade on 6/22/17.
//  Copyright © 2017 Jaime Andrade. All rights reserved.
//

import UIKit
import AVFoundation // for use sound while tap an object

class ViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var chompPlayer: AVAudioPlayer? = nil

    /*func loadSound(filename: String) -> AVAudioPlayer{
        let url = Bundle.main.url(forResource: filename, withExtension: "caf")
        var error:NSError? = nil
        let player: AVAudioPlayer!
        do{
        try player = AVAudioPlayer(contentsOf: url!)
            player.prepareToPlay()
            return player
        }catch {
            print()
            return AVAudioPlayer()
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        recognizer.delegate = self
        view.addGestureRecognizer(recognizer)
        self.chompPlayer = self.loadSound(filename: "chomp")*/
        
    }
    
   /* func handleTap(recognizer: UITapGestureRecognizer){
        self.chompPlayer?.play()
    }
    
    func imprime(){
        print("tap....")
    }*/
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        
        print("tap.....")
        let translation1 = recognizer.translation(in: self.view)
        if let view1 = recognizer.view {
            view1.center = CGPoint(x:view1.center.x + translation1.x,
                                  y:view1.center.y + translation1.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func handlePanOther(recognizer:UIPanGestureRecognizer) {
        
        print("tap.....")
        let translation2 = recognizer.translation(in: self.view)
        if let view2 = recognizer.view {
            view2.center = CGPoint(x:view2.center.x + translation2.x,
                                  y:view2.center.y + translation2.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        //descrease speed until stop objet when end panGesture
        if recognizer.state == UIGestureRecognizerState.ended{
            let velocity = recognizer.velocity(in: self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            print("magnitude: \(magnitude), slideMultipler: \(slideMultiplier)")
            
            //2
            let slideFactor = 0.1 * slideMultiplier //increase for more of a slide
            //3
            var finalPoint = CGPoint(x: recognizer.view!.center.x + (velocity.x * slideFactor),
                                     y: recognizer.view!.center.y + (velocity.y * slideFactor))
            
            //4
            finalPoint.x  = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            //5
            UIView.animate(withDuration: Double(slideFactor * 2), delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { 
                recognizer.view!.center = finalPoint
            }, completion: nil)
        }
    }
    
    
    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer){
        if let view = recognizer.view{
            view.transform = CGAffineTransform.init(scaleX: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @IBAction func handlePinchOther(recognizer: UIPinchGestureRecognizer){
        if let view = recognizer.view{
            view.transform = CGAffineTransform.init(scaleX: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @IBAction func handleRotate(recognizer: UIRotationGestureRecognizer){
        if let view = recognizer.view{
            view.transform = CGAffineTransform.init(rotationAngle: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    
    //function of UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    

}

