# RRCircularViewSlider

## Example
<img src="https://github.com/Rahul-Mayani/RRCircularViewSlider/blob/master/sample.gif" width="300">

## Requirements

- iOS 10.0+
- Xcode 11

## Installation

#### Manually
1. Download and drop ```RRCircularView.swift``` in your project.  
2. Congratulations!  

## Usage example

```swift
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
```

## Contribute

We would love you for the contribution to **RRCircularViewSlider**, check the ``LICENSE`` file for more info.


## License

RRCircularViewSlider is available under the MIT license. See the LICENSE file for more info.


