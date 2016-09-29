//
//  SettingsViewController.swift
//  Tip-Calculator
//
//  Created by Guanlong Zhou on 9/27/16.
//  Copyright © 2016 Guanlong Zhou. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var defaultTipRateValue : Int = 20
    var isUseSimpleSelection = true
    
    @IBOutlet weak var defaultTipRateController: UISegmentedControl!
    
    @IBOutlet weak var defaultTipRateLabel: UILabel!
    
    @IBOutlet weak var defaultTipRateSlideBar: UISlider!
    
    @IBOutlet weak var simpleRateSwitch: UISwitch!
    
    @IBAction func simpleRateSwitchChanged(_ sender: AnyObject) {
        isUseSimpleSelection = simpleRateSwitch.isOn
        if(isUseSimpleSelection){
            if(defaultTipRateValue>=22){
                defaultTipRateController.selectedSegmentIndex = 2
                defaultTipRateValue = 22
            }
            else if(defaultTipRateValue<=18){
                defaultTipRateController.selectedSegmentIndex = 0
                defaultTipRateValue = 18
            }
            else{
                defaultTipRateController.selectedSegmentIndex = 1
                defaultTipRateValue = 20
            }
            
        }
        else{
            defaultTipRateSlideBar.value = Float(defaultTipRateValue)
        }
        refreshSettingsView()
    }
    
    func refreshSettingsView(){
        defaultTipRateController.isHidden = !isUseSimpleSelection
        defaultTipRateSlideBar.isHidden = isUseSimpleSelection
        defaultTipRateLabel.text = String(defaultTipRateValue) + "%"
        simpleRateSwitch.isOn = isUseSimpleSelection
        defaultTipRateSlideBar.value = Float(defaultTipRateValue)
        if(isUseSimpleSelection){
            let tipRates : [Int] = [18, 20, 22]
            defaultTipRateController.selectedSegmentIndex = tipRates.index(of: defaultTipRateValue) ?? 0
        }
        
        saveStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //defaultTipRateController.selectedSegmentIndex
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func setDefaultTipRate(_ sender: AnyObject) {
        if(isUseSimpleSelection){
            let simpleRates = [18, 20, 22]
            defaultTipRateValue = simpleRates[defaultTipRateController.selectedSegmentIndex]
        }
        else{
            defaultTipRateValue = Int(defaultTipRateSlideBar.value)
        }
        refreshSettingsView()
        saveStatus()
    }
    
    func saveStatus(){
    let defaults = UserDefaults.standard
    defaults.set(defaultTipRateValue, forKey:"defaultSelectedTipRate")
    defaults.set(isUseSimpleSelection,forKey:"isUseSimpleSelection")
    defaults.synchronize()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        if((defaults.object(forKey: "isUseSimpleSelection")) != nil){
            defaultTipRateValue = defaults.integer(forKey: "defaultSelectedTipRate")
            
            isUseSimpleSelection = defaults.bool(forKey: "isUseSimpleSelection")
        }
        else{
           saveStatus()
        }
        
        refreshSettingsView()
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
