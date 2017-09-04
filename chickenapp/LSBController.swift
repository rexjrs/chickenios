//
//  LSBController.swift
//  chickenapp
//
//  Created by Thomas on 8/31/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import UIKit

class LSBController: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.tabBarController?.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.tabBarController?.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
