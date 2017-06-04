//
//  SettingsViewController.swift
//  TipCalculate
//
//  Created by Triet on 6/2/17.
//  Copyright © 2017 Triet. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var Tip1Slider: UISlider!
  @IBOutlet weak var Tip2Slider: UISlider!
  @IBOutlet weak var Tip3Slider: UISlider!
  
  @IBOutlet weak var Tip1Label: UILabel!
  @IBOutlet weak var Tip2Label: UILabel!
  @IBOutlet weak var Tip3Label: UILabel!
  
  // Declare variable use for update value
  var NewPercentage = [0.0,0.0,0.0]
  let DefaultPercentage = [0.18,0.2,0.25]
		

  @IBOutlet weak var SetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    LoadPercentageValue(inputArray:CurrentPercentage)
    NewPercentage = CurrentPercentage
  }
  @IBAction func UpdateNewValue(_ sender: Any)
  {
//    UpdatePercentage[0] = 0.3
    for index in 0...2{
      UpdatePercentage[index] = NewPercentage[index]
    }
  }
  @IBAction func RestoreCurrentValue(_ sender: Any) {
    LoadPercentageValue(inputArray:CurrentPercentage)
    NewPercentage = CurrentPercentage
  }
  @IBAction func SetDefaultValue(_ sender: Any) {
    LoadPercentageValue(inputArray:DefaultPercentage)
    NewPercentage = DefaultPercentage
  }

  @IBAction func Slider1ValueChange(_ sender: Any) {
    let valueChange = round(Tip1Slider.value)
    Tip1Label.text = String(format: "%.0f",valueChange)
    NewPercentage[0] = Double(valueChange/100)
  }
  
  @IBAction func Slider2ValueChange(_ sender: Any) {
    let valueChange = round(Tip2Slider.value)
    Tip2Label.text = String(format: "%.0f",valueChange)
    NewPercentage[1] = Double(valueChange/100)
  }
  
  @IBAction func Slider3ValueChange(_ sender: Any) {
    let valueChange = round(Tip3Slider.value)
    Tip3Label.text = String(format: "%.0f",valueChange)
    NewPercentage[2] = Double(valueChange/100)
  }
  
  func LoadPercentageValue(inputArray: Array<Double>){
    Tip1Slider.setValue(Float(inputArray[0]*100), animated: true)
    Tip2Slider.setValue(Float(inputArray[1]*100), animated: true)
    Tip3Slider.setValue(Float(inputArray[2]*100), animated: true)
    
    Tip1Label.text = String(format: "%.0f%",inputArray[0]*100)
    Tip2Label.text = String(format: "%.0f%",inputArray[1]*100)
    Tip3Label.text = String(format: "%.0f%",inputArray[2]*100)

  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
