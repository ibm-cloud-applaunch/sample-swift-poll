/*
 *     Copyright 2018 IBM Corp.
 *     Licensed under the Apache License, Version 2.0 (the "License");
 *     you may not use this file except in compliance with the License.
 *     You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *     Unless required by applicable law or agreed to in writing, software
 *     distributed under the License is distributed on an "AS IS" BASIS,
 *     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *     See the License for the specific language governing permissions and
 *     limitations under the License.
 */

//
//  ViewController.swift
//  AppLaunch Poll
//
//  Created by Vittal Pai on 1/29/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit
import IBMAppLaunch

class ViewController: UIViewController {
    
    var popUpText:String = "Sample Text"
    var popUpYes:String = "Yes"
    var popUpNo:String = "No"
    @IBOutlet weak var pollButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try  AppLaunch.sharedInstance.displayInAppMessages()
        } catch {
            print("AppLaunch SDK is not Initialized")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkIfFeatureEnabled()
        self.checkIfThemeFeatureEnabled()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logout(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
        self.navigationController?.popViewController(animated: true)
    }
    
    private func checkIfFeatureEnabled() {
        do {
            if try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_p1ie0h4t3") {
                pollButton.isHidden = false
                popUpText = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_p1ie0h4t3", propertyCode: "_1kbhwoivq")
                popUpYes = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_p1ie0h4t3", propertyCode: "_bs8u6x9f0")
                popUpNo = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_p1ie0h4t3", propertyCode: "_e9a5i8cmv")
            } else {
                pollButton.isHidden = true
            }
            
        } catch {
            print("AppLaunch SDK is not Initialized")
        }
    }
    
    private func checkIfThemeFeatureEnabled() {
        do {
            if try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_k5gt353bi") {
                let backgroundColor = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_k5gt353bi", propertyCode: "_y9m77plvx")
                let buttonColor = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_k5gt353bi", propertyCode: "_agrdr1f12")
                self.view.backgroundColor = hexStringToUIColor(backgroundColor)
                self.pollButton.backgroundColor = hexStringToUIColor(buttonColor)
            }
            
        } catch {
            print("AppLaunch SDK is not Initialized")
        }
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        let alert = UIAlertController(title: popUpText, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: popUpYes, style: .default, handler: { (action: UIAlertAction!) in
            do{
                try AppLaunch.sharedInstance.sendMetrics(codes: ["_ycc4tikio"])
            }catch{
                print("AppLaunch SDK is not Initialized")
            }
        }))
        alert.addAction(UIAlertAction(title: popUpNo, style: .destructive, handler: { (action: UIAlertAction!) in
            do{
                try AppLaunch.sharedInstance.sendMetrics(codes: ["_w5f9cv718"])
            }catch{
                print("AppLaunch SDK is not Initialized")
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
    
}

