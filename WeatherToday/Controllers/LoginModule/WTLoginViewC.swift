//
//  ViewController.swift
//  WeatherToday
//
//  Created by Minakshi Bawa on 16/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import UIKit

class WTLoginViewC: WTBaseViewC
{
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    //MARK: - Variable Declaration -
    
    //MARK: - View LifeCycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     //MARK: - IBAction Methods -

    @IBAction func tapLoginBtn(_ sender: UIButton)
    {
       if checkVal()
       {
        self.showOkAlert(withMessage: kMSGLoginSucc, andHandler: {
            self.txtPwd.text = ""
            self.txtUserName.text = ""
            // navigate to home screen
            let sb = UIStoryboard.init(name: kSbMain, bundle: nil)
            let destViewC = sb.instantiateViewController(withIdentifier: "WTHomeViewC") as! WTHomeViewC
            self.navigationController?.pushViewController(destViewC, animated: true)
        })
        }
      
    }
    
     //MARK: - Private Methods -
    
    func configView()
    {
        // Set Border color and round it
        txtUserName.layer.cornerRadius = 10
        txtUserName.layer.borderColor = UIColor.white.cgColor
        txtUserName.layer.borderWidth = 1
        txtUserName.layer.masksToBounds = true
        
        txtPwd.layer.cornerRadius = 10
        txtPwd.layer.borderColor = UIColor.white.cgColor
        txtPwd.layer.borderWidth = 1
        txtPwd.layer.masksToBounds = true
        
        btnLogin.layer.cornerRadius = 10
        btnLogin.layer.masksToBounds = true
        
        // set padding
        txtPwd.setLeftPaddingPoints(10.0)
        txtUserName.setLeftPaddingPoints(10.0)
    }
    
    func checkVal() -> Bool
    {
        if txtUserName.text?.count == 0
        {
            self.showOkAlert(withMessage:kMSGUserEmpty)
            return false
        }
        else if txtPwd.text?.count == 0
        {
            self.showOkAlert(withMessage:kMSGPwdEmpty)
            return false
        }
        else if txtUserName.text != "abc" && txtPwd.text != "123456"
        {
            // Logged credentials invalid
            self.showOkAlert(withMessage: kMSGInvCred)
            return false
        }
        return true
    }
    
}

//MARK: - UITextField Delegate Methods -

extension WTLoginViewC:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == txtUserName
        {
            txtPwd.becomeFirstResponder()
            return false
        }
        return self.view.endEditing(true)

    }
    
}
