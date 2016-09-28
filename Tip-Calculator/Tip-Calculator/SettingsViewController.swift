//
//  SettingsViewController.swift
//  Tip-Calculator
//
//  Created by Guanlong Zhou on 9/27/16.
//  Copyright © 2016 Guanlong Zhou. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipRateController: UISegmentedControl!
    
    
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
        
        let defaults = UserDefaults.standard
        defaults.set(defaultTipRateController.selectedSegmentIndex, forKey:"defaultSelectedTipIndex")
        defaults.synchronize()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        
        let defaultIndex = defaults.integer(forKey: "defaultSelectedTipIndex")
        
        defaultTipRateController.selectedSegmentIndex = defaultIndex
        
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
