//
//  AppData.swift
//  chickenapp
//
//  Created by Thomas on 8/30/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import Foundation
import SwiftyJSON

var drawerItems = ["Shopping","Enroll","News","Media","Login"]

var authPass = false{
    didSet{
        if(authPass){
            drawerItems = ["Shopping","Enroll","Genealogy","Success","Commission","Reports","News","Media","Profile","Logout"]
        }else{
            drawerItems = ["Shopping","Enroll","News","Media","Login"]
        }
    }
}

var loginTokens = JSON("temp")

var customerData = JSON("temp")

public func setInitialData(){
    drawerItems = ["Shopping","Enroll","News","Media","Login"]
    authPass = false
    loginTokens = JSON("temp")
    customerData = JSON("temp")
}
