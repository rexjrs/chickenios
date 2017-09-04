//
//  KPIController.swift
//  chickenapp
//
//  Created by Thomas on 8/31/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import UIKit

class KPIController: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
