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
    
    let tipPercentages = [0.18, 0.20, 0.22]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTapMainScreen(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill : Double = Double(billField.text!) ?? 0
        if(bill > 9999999){
            let alertController = UIAlertController(title: "iOScreator", message:
                "Number is too big!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = tip + bill
        
        
        tipLabel.text = String(format:"$%.2f", tip)
        totalLabel.text = String(format:"$%.2f", total)
        
        let defaults = UserDefaults.standard
        defaults.set(billField.text!, forKey:"presetBillValue")
        defaults.synchronize()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        
        let defaultIndex = defaults.integer(forKey: "defaultSelectedTipIndex")
        
        billField.text = defaults.string(forKey: "presetBillValue") ?? "0"
        
        tipControl.selectedSegmentIndex = defaultIndex
        calculateTip("Calculate!" as AnyObject)
        
    }
    
    
    func applicationDidEnterBackground(application: UIApplication) {


    }
    
    
}

