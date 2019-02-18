//
//  ViewController.swift
//  Rain
//
//  Created by Enrico Castelli on 06/08/2018.
//  Copyright © 2018 Enrico Castelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var grey : UIView?
    var light : UIView?
    var dur = 0.25
    var emitter : CAEmitterLayer?
    var emitterCell = CAEmitterCell()
    var sun = false
    var count = 0
    var countLimit = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addRain()
        self.perform(#selector(animateLight), with: nil, afterDelay: 1)

    }
    
    func addRain() {
        grey = UIView(frame: self.view.frame)
        grey!.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.insertSubview(grey!, at: 1)
        
        light = UIView(frame: self.view.frame)
        light?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.view.addSubview(light!)
        light?.alpha = 0
        
        emitter = CAEmitterLayer()
        emitter!.emitterPosition = CGPoint(x: self.view.bounds.width/2, y: -900)
        emitter!.emitterZPosition = 0
        emitter!.emitterSize = self.view.bounds.size
        emitter!.emitterShape = kCAEmitterLayerPoint
        
        emitterCell.scale = 0.02
        emitterCell.scaleRange = 0.06
        emitterCell.emissionRange = 3
        emitterCell.lifetime = 3.0
        emitterCell.birthRate = 3000
        emitterCell.velocity = 400
        emitterCell.velocityRange = 200
        emitterCell.yAcceleration = 300
        emitterCell.xAcceleration = 0
        emitterCell.contents = #imageLiteral(resourceName: "rain").cgImage
        emitter!.emitterCells = [emitterCell]
        self.view.layer.addSublayer(emitter!)
    }

    @objc func animateLight() {
        if count < countLimit {
            if sun == false {
                UIView.animate(withDuration: self.dur, delay: 0, options: .autoreverse, animations: {
                    self.light?.alpha = 1
                }) { (done) in
                    self.light?.alpha = 0
                    self.count += 1
                    self.dur = 0.05
                    self.animateLight()
                }
            }
        } else {
            count = 0
            self.dur = 0.30
            countLimit = 3
            self.perform(#selector(animateLight), with: nil, afterDelay: 5)
        }
    }

}

