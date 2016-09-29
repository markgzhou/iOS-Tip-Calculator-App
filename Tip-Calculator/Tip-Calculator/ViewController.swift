//
//  ViewController.swift
//  Tip-Calculator
//
//  Created by Guanlong Zhou on 9/26/16.
//  Github: mookerz
//  Copyright © 2016 Guanlong Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var tipRateSlideBar: UISlider!
    @IBOutlet weak var tipRateLabel: UILabel!
    @IBOutlet weak var keyboardStatusLabel: UILabel!
    
    let tipPercentages = [18, 20, 22]
    var tipRateValue : Int = 20
    var isUseSimpleSelection = true
    var isKeyboardOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setKeyboardTextOn(isKeyboardOn: Bool){
        if(isKeyboardOn){
            keyboardStatusLabel.text = "Keyboard: On"
            keyboardStatusLabel.textColor = UIColor.black
            keyboardStatusLabel.backgroundColor = UIColor.lightGray
        }else{
            keyboardStatusLabel.text = "Keyboard: Off"
            keyboardStatusLabel.textColor = UIColor.black
            keyboardStatusLabel.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func billFieldEditingBegin(_ sender: AnyObject) {
        setKeyboardTextOn(isKeyboardOn: true)
        isKeyboardOn = true
    }

    @IBAction func onTapMainScreen(_ sender: AnyObject) {
        if(isKeyboardOn){
            view.endEditing(true)
            isKeyboardOn = false
        }
        else{
            billField.becomeFirstResponder()
            isKeyboardOn = true
        }
        setKeyboardTextOn(isKeyboardOn: isKeyboardOn)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        var bill: Double = Double(billField.text!) ?? 0
        
        if(bill > 9999999){
            let alertController = UIAlertController(title: "Warning!", message:
                "Number is too big!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            billField.text = ""
            bill = 0
        }
        
        if(isUseSimpleSelection){
            tipRateValue = tipPercentages[tipControl.selectedSegmentIndex]
        }
        else{
            tipRateValue = Int(tipRateSlideBar.value)
        }
        
        
        let tip : Double = bill * Double(tipRateValue)/100
        let total = tip + bill
        
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        
        
        tipLabel.text = formatter.string(from: NSNumber.init(value: tip))
        totalLabel.text = formatter.string(from: NSNumber.init(value: total))
        
        let defaults = UserDefaults.standard
        defaults.set(billField.text!, forKey:"presetBillValue")
        refreshCalculatorView()
        defaults.synchronize()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        if((defaults.object(forKey: "isUseSimpleSelection")) != nil){
            tipRateValue = defaults.integer(forKey: "defaultSelectedTipRate")
            
            isUseSimpleSelection = defaults.bool(forKey: "isUseSimpleSelection")
            
            billField.text = defaults.string(forKey: "presetBillValue")
        }
        else{
            saveStatus()
        }
        
        refreshCalculatorView()

        calculateTip("Calculate!" as AnyObject)
        
    }
    
    func refreshCalculatorView(){
        tipControl.isHidden = !isUseSimpleSelection
        tipRateSlideBar.isHidden = isUseSimpleSelection
        tipRateLabel.text = String(tipRateValue) + "%"
        tipRateSlideBar.value = Float(tipRateValue)
        if(isUseSimpleSelection){
            tipControl.selectedSegmentIndex = tipPercentages.index(of: Int(tipRateValue)) ?? 0
        }
        tipRateLabel.text = String(tipRateValue) + "%"
        saveStatus()
    }
    
    func saveStatus(){
        let defaults = UserDefaults.standard
        //defaults.set(tipRateValue, forKey:"defaultSelectedTipRate")
        defaults.set(isUseSimpleSelection,forKey:"isUseSimpleSelection")
        defaults.synchronize()
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {


    }
    
    
}

