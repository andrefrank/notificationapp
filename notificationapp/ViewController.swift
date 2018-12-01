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
    
    var noti = LocalPushManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocalPushManager.shared.requestPermission()
        LocalPushManager.shared.sendLocalPush(in: 60)
    }


    @IBAction func pressedTimer(_ sender: Any) {
        noti.skipp.toggle()
        print(noti.skipp)
        
    }
}

