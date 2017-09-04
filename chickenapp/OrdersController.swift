//
//  OrdersController.swift
//  chickenapp
//
//  Created by Thomas on 8/31/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrdersController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var orderTableData = [] as Array

    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var orderTable: UITableView!
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderTable.isHidden = true
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.tabBarController?.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.tabBarController?.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.orderTable.delegate = self
        self.orderTable.dataSource = self
        
        if let token = loginTokens["token"].string{
            getReport(token: token, month: "1"){success in
                print(success[0]["orderid"]!)
                self.orderTableData = success
                self.orderTable.isHidden = false
                self.loadingSpinner.stopAnimating()
                self.orderTable.reloadData()
            }
        }

    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return orderTableData.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCellController
        if let orderId = orderTableData[indexPath.row] as? [String : Any]{
            cell.orderNumber.text = orderId["orderid"] as? String
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "ShowOrderDetail", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        orderTable.reloadData()
    }
}
