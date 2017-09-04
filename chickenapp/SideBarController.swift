//
//  SideBarController.swift
//  chickenapp
//
//  Created by Thomas on 8/29/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import UIKit

class SideBarController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var drawerTables: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width-70
        self.drawerTables.delegate = self
        self.drawerTables.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return drawerItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drawerCell", for: indexPath) as! DrawerCell
        cell.cellName.text = drawerItems[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(drawerItems[indexPath.row] != "Logout"){
            self.performSegue(withIdentifier: (drawerItems[indexPath.row]+"Route"), sender: nil)
        }else{
            setInitialData()
            UserDefaults.standard.removeObject(forKey: "loginTokens")
            UserDefaults.standard.removeObject(forKey: "customerData")
            drawerTables.reloadData()
        }
        self.drawerTables.deselectRow(at: indexPath, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        drawerTables.reloadData()
    }

}
