//
//  DetectionAreaView.swift
//  ChekinScannerTest
//
//  Created by Alejandro Ruiz Ponce on 28/02/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit

class DetectionAreaView: UIView {
    var color = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    var radius: CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    var thickness: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    var length: CGFloat = 30 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        
        let t2 = thickness / 2
        let path = UIBezierPath()
        // Top left
        path.move(to: CGPoint(x: t2, y: length + radius + t2))
        path.addLine(to: CGPoint(x: t2, y: radius + t2))
        path.addArc(withCenter: CGPoint(x: radius + t2, y: radius + t2), radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: true)
        path.addLine(to: CGPoint(x: length + radius + t2, y: t2))
        
        // Top right
        path.move(to: CGPoint(x: frame.width - t2, y: length + radius + t2))
        path.addLine(to: CGPoint(x: frame.width - t2, y: radius + t2))
        path.addArc(withCenter: CGPoint(x: frame.width - radius - t2, y: radius + t2), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 3 / 2, clockwise: false)
        path.addLine(to: CGPoint(x: frame.width - length - radius - t2, y: t2))
        
        // Bottom left
        path.move(to: CGPoint(x: t2, y: frame.height - length - radius - t2))
        path.addLine(to: CGPoint(x: t2, y: frame.height - radius - t2))
        path.addArc(withCenter: CGPoint(x: radius + t2, y: frame.height - radius - t2), radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: false)
        path.addLine(to: CGPoint(x: length + radius + t2, y: frame.height - t2))
        
        // Bottom right
        path.move(to: CGPoint(x: frame.width - t2, y: frame.height - length - radius - t2))
        path.addLine(to: CGPoint(x: frame.width - t2, y: frame.height - radius - t2))
        path.addArc(withCenter: CGPoint(x: frame.width - radius - t2, y: frame.height - radius - t2), radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: frame.width - length - radius - t2, y: frame.height - t2))
        
        path.lineWidth = thickness
        path.stroke()
    }
}
