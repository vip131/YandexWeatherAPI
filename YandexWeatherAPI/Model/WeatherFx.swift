//
//  WeatherFx.swift
//  YandexWeatherAPI
//
//  Created by Admin on 11.01.2021.
//  Copyright © 2021 DmitryChaschin. All rights reserved.
//

import Foundation
import UIKit
struct WeatherFx {
    
    func letItSnow(on view: UIImageView) {
        removeEmitter(from: view)
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "snowFlake.png")!.cgImage
        cell.birthRate = 50
        cell.lifetime = 4
        cell.velocity = 100
        cell.scale = 0.07
        cell.alphaSpeed = 3
        cell.emissionRange = CGFloat.pi * 2.0
        cell.scaleRange = 0.1
        cell.velocityRange = -20
        cell.yAcceleration = 6
        cell.xAcceleration = 5
        cell.spin = -0.5
        cell.spinRange = 1.0
        
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x:view.frame.midX  , y: -150)
        emitter.emitterCells = [cell]
        
        view.layer.addSublayer(emitter)
    }
    
    func letItRain(on view: UIImageView) {
        removeEmitter(from: view)
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "rainDrop.png")!.cgImage
        cell.birthRate = 50
        cell.lifetime = 10
        cell.velocity = 100
        cell.scale = 0.08
        cell.emissionLongitude = (180 * (.pi/180))
        
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.frame.size.width / 2.0, y: 0)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        emitter.emitterCells = [cell]
        
        view.layer.addSublayer(emitter)
    }
    
    func removeEmitter(from view: UIImageView) {
        if let sublayer = view.layer.sublayers {
            for i in sublayer {
                i.removeFromSuperlayer()
            }
        }
    }
    
}
