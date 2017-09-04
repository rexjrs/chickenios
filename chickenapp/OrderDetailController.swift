//
//  OrderDetailController.swift
//  chickenapp
//
//  Created by Thomas on 8/31/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import UIKit

class OrderDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.view.removeGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
