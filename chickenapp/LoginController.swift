//
//  LoginController.swift
//  chickenapp
//
//  Created by Thomas on 8/30/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingSpinner.hidesWhenStopped = true
        self.loadingSpinner.stopAnimating()
        self.errorMsg.isHidden = true
        self.loginBtn.layer.cornerRadius = 17.5
        self.userField.layer.cornerRadius = 20
        self.userField.layer.borderWidth = 0.5
        self.userField.layer.borderColor = UIColor(red: 219/255, green: 226/255, blue: 232/255, alpha: 1.0).cgColor
        self.passwordField.layer.cornerRadius = 20
        self.passwordField.layer.borderWidth = 0.5
        self.passwordField.layer.borderColor = UIColor(red: 219/255, green: 226/255, blue: 232/255, alpha: 1.0).cgColor
        self.userField.delegate = self
        self.userField.tag = 0
        self.passwordField.delegate = self
        self.passwordField.tag = 1
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginUser(sender: "")
            return true;
        }
        return false
    }
    
    @IBAction func loginUser(_ sender: Any) {
        if let username = self.userField.text{
            if let password = self.passwordField.text{
                if(username == "" || password == ""){
                    self.errorMsg.isHidden = false
                }else{
                    self.errorMsg.isHidden = true
                    dismissKeyboard()
                    loginSubmit()
                }
            }
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func loginSubmit(){
        self.loadingSpinner.startAnimating()
        self.loginBtn.isHidden = true
        let userPass = self.userField.text!+":"+self.passwordField.text!
        let data = (userPass).data(using: String.Encoding.utf8)
        let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        authenticate(userPass: base64){success in
            if success["customer"].exists(){
                getUserData(token: success["token"].string!, href: success["customer"]["href"].string!){successNew in
                    if let customerStringData = successNew.rawString(){
                        UserDefaults.standard.set(customerStringData, forKey: "customerData")
                    }
                    customerData = successNew
                    authPass = true
                    self.dismiss(animated: true, completion: nil)
                }
                if let stringData = success.rawString(){
                    UserDefaults.standard.set(stringData, forKey: "loginTokens")
                }
                loginTokens = success
            }else{
                self.errorMsg.isHidden = false
                self.loadingSpinner.stopAnimating()
                self.loginBtn.isHidden = false
            }
        }
    }
}
