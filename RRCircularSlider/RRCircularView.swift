//
//  RRCircularView.swift
//  RRCircularSlider
//
//  Created by Rahul Mayani on 25/11/19.
//  Copyright © 2019 RR. All rights reserved.
//

import Foundation
import UIKit


open class RRCircularView: UIView {
    
    // MARK: Variable
    public var fontOfGlobLabel: UIFont = UIFont.systemFont(ofSize: 25, weight: .bold) {
        didSet {
            globLabel.font = fontOfGlobLabel
        }
    }
    public var textColorOfGlobLabel: UIColor = UIColor.white {
        didSet {
            globLabel.textColor = textColorOfGlobLabel
        }
    }
    
    // slider color selection ring
    public var ringImageView: UIImageView!
    
    // indicate selected color on the ring imageview
    public var dotImageView: UIImageView!
    
    // rotate of selction around the ring imageview and changed color based on selection (Both image set as template mode)
    public var arrowImageView: UIImageView!
    public var globImageView: UIImageView!
    
    // show slider selection value
    private var globLabel: UILabel!
    
    // choose color based on slider value
    public var tintColorImage: UIImage = #imageLiteral(resourceName: "gradient")
    
    public var value: Float = 0.0 {
        didSet {
            globLabel.text = "\(Int(value))"
            setValue(newValue: Double(value), animated: true)
            globImageView.tintColor = tintColorImage.getPixelColor(pos: CGPoint(x: Int(value), y: 0))
            arrowImageView.tintColor = globImageView.tintColor
        }
    }
    
    public var minimumValue = 0.0
    public var maximumValue = 500.0
    public var maxAngle = 135.0
    
    private var defaultValue = 0.0
    
    // MARK: Lifecycle
    private func renderUI() {
        
        ringImageView = createImageView()
        dotImageView = createImageView()
        arrowImageView = createImageView()
        globImageView = createImageView()
        
        globLabel = UILabel(frame: self.bounds)
        self.addSubview(globLabel)
        
        globLabel.textColor = textColorOfGlobLabel
        globLabel.font = fontOfGlobLabel
        globLabel.textAlignment = .center
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        renderUI()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        renderUI()
    }
    
    // MARK: Others
    private func createImageView() -> UIImageView {
        let imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        return imageView
    }
}

extension RRCircularView {
    
    private func angleForValue(_ value: Double) -> Double {
        return ((value - minimumValue)/(maximumValue - minimumValue) - 0.5) * (maxAngle*2.0)
    }
    
    private func valueForAngle(_ angle: Double) -> Double {
        return ((angle/(self.maxAngle*2.0) + 0.5) * (self.maximumValue - self.minimumValue) + self.minimumValue)
    }
    
    private func setValue(newValue: Double, animated: Bool) {
        let oldValue = defaultValue

        if (newValue < minimumValue) {
            defaultValue = minimumValue
        } else if (newValue > maximumValue) {
            defaultValue = maximumValue
        } else {
            defaultValue = newValue
        }

        valueDidChangeFrom(oldValue: oldValue, to: defaultValue, animated: animated)
    }
    
    private func valueDidChangeFrom(oldValue: Double, to newValue: Double, animated: Bool) {
        let newAngle = angleForValue(newValue)
        if animated {
            let oldAngle = angleForValue(oldValue)
            
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            animation.duration = 0.2
            animation.values = [(oldAngle * .pi/180.0), ((newAngle + oldAngle)/2.0 * .pi/180.0), (newAngle * .pi/180.0)]
            animation.keyTimes = [0.0, 0.5, 1.0]

            animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn), CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
            dotImageView.layer.add(animation, forKey: nil)
            arrowImageView.layer.add(animation, forKey: nil)
        }
        let transform = CGAffineTransform(rotationAngle: CGFloat(newAngle * .pi/180.0))
        dotImageView.transform = transform
        arrowImageView.transform = transform
    }
}

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {

        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = Int(pos.x) * 4
        //let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        //let pixelInfo: Int = ((500 * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
