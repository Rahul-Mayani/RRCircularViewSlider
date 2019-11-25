//
//  ViewController.swift
//  RRCircularSlider
//
//  Created by Rahul Mayani on 25/11/19.
//  Copyright © 2019 RR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circularView: RRCircularView!
    
    @IBOutlet weak var slider: UISlider!
            
    override func viewDidLoad() {
        super.viewDidLoad()
                                
        circularView.arrowImageView.image = #imageLiteral(resourceName: "gren_round_arrow")
        circularView.globImageView.image = #imageLiteral(resourceName: "gren_round")
        circularView.ringImageView.image = #imageLiteral(resourceName: "round_color")
        circularView.dotImageView.image = #imageLiteral(resourceName: "black_dot")
        circularView.tintColorImage = #imageLiteral(resourceName: "gradient")
                
        slider.minimumValue = Float(circularView.minimumValue)
        slider.maximumValue = Float(circularView.maximumValue)
        
        slider.value = Float(circularView.minimumValue)
        
        sliderValueChanged(sender: slider)
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        circularView.value = slider.value
    }
}

