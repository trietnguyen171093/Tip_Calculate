//
//  ViewController.swift
//  TipCalculate
//
//  Created by Triet on 5/29/17.
//  Copyright © 2017 Triet. All rights reserved.
//

import UIKit

var CurrentPercentage = [0.18, 0.2, 0.25]
var UpdatePercentage = [0.0,0.0,0.0]
let firstLauchAfterInstallKey = "Install"
var firstLauchAfterRevoke = true
var currencySymbol = ""

class ViewController: UIViewController {

  @IBOutlet weak var billField: UITextField!
  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // Load the current currency
    let locale = Locale.current
    currencySymbol = locale.currencySymbol!
    // Update the currency for some labels
    tipLabel.text = String(currencySymbol) + "0.00"
    totalLabel.text = String(currencySymbol) + "0.00"
      }

  override func viewDidAppear(_ animated: Bool) {
    // if this is the first lauch then retreive the percentage data
    if firstLauchAfterRevoke == true{
      UpdatePercentage = retreivePercentageData()
    }
    
    // Load new percentage tip value if any change
    for index in 0...2{
          if (UpdatePercentage[index] != CurrentPercentage[index])
          {
            CurrentPercentage[index] = UpdatePercentage[index]
            tipControl.setTitle(String(round(UpdatePercentage[index]*100)) + "%", forSegmentAt: index)
          }
    }
    
    // Store the new percentage data
    storePercentageData(inputArray: UpdatePercentage)
    
    // Update the value for total tip
    calculateTip(0)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  /*
   This func is use for retreive the percentage data
   It returns a array in Double-type
 */
  func retreivePercentageData() ->  Array<Double> {
    
    // Initialize variables need for retreive
    let defaults = UserDefaults.standard
    var retreiveData = [0.0,0.0,0.0]
    var stringKey = "Percentage"  // using this string as a key to store percentage data
    // Obtain the percentage data
    for index in 0...2{
      stringKey += String(index)
      retreiveData[index] =  defaults.double(forKey: stringKey)
      // If this is the first lauch of after installation, using the default data
      if (isFirstLauchAfterInstall() == 0){
        retreiveData[index] = CurrentPercentage[index]
      }
    }
    
    firstLauchAfterRevoke = false
    return(retreiveData)
  }
  func storePercentageData(inputArray: Array<Double>){
    // Initialize variables to store the current Percaentage data
    let storedata = UserDefaults.standard
    var stringKey = "Percentage"
    // Store Percentage data
    for index in 0...2{
      stringKey += String(index)
      storedata.set(inputArray[index], forKey: stringKey)
    }
    storedata.set(1, forKey: firstLauchAfterInstallKey) // mark the first-lauch after installation is used
    storedata.synchronize()
  }
  /*
    This func return the value:
    0: It's the first time lauching app after installation
    1: NOT first time lauching app after installation
   */
  func isFirstLauchAfterInstall() -> Int {
    let defaults = UserDefaults.standard
    return defaults.integer(forKey: firstLauchAfterInstallKey)
  }
  @IBAction func onTap(_ sender: Any) {
  
    view.endEditing(true)
  }
  
  @IBAction func calculateTip(_ sender: Any) {
    
    
    let bill = Double(billField.text!) ?? 0
    let tip = bill * CurrentPercentage[tipControl.selectedSegmentIndex]
    let total = bill + tip
    
    tipLabel.text = currencySymbol + String(format: "%.2f",tip)
    totalLabel.text = currencySymbol + String(format: "%.2f",total)
  }

  
}

