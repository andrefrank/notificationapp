//
//  ViewController.swift
//  notificationapp
//
//  Created by Daniel Keglmeier on 30.11.18.
//  Copyright © 2018 Daniel Keglmeier. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var textFiel: UITextField!
    
    @IBOutlet weak var toggleBackgroundModeButton: UIButton!
    @IBOutlet weak var toggleShowButton: UIButton!
    
    var noti = LocalPushManager()
    var backgroundModeIsEnabled:Bool=true{
                 willSet{
                    LocalPushManager.shared.backgroundMode_Fetch(enable:newValue)
                    let buttonText=newValue ? "Disable Background mode" : "Enable Background mode"
                    toggleBackgroundModeButton.setTitle(buttonText, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocalPushManager.shared.requestPermission()
        //LocalPushManager.shared.sendLocalPush(in: 60)
        backgroundModeIsEnabled=true
    }

    @IBAction func toggleBackgroundMode(_ sender: Any) {
        backgroundModeIsEnabled = !backgroundModeIsEnabled
    }
    
    

    @IBAction func toggleShow(_ sender: Any) {
        //Invert
        //Doesn't work for backgroundMode
        noti.skipp = !noti.skipp
        let textButton = noti.skipp ? "Fake a Show is available" : "Fake a show isn't available"
        toggleShowButton.setTitle(textButton, for: .normal)
    }
    
    
    
}

