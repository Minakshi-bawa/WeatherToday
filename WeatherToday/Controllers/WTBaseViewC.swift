//
//  WTBaseViewC.swift
//  WeatherToday
//
//  Created by Minakshi Bawa on 16/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import UIKit

class WTBaseViewC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- ----------UIAlertController Methods----------
    func showOkAlert(withMessage message: String)
    {
        let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        let okAction =  (UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showOkAlert(withMessage message: String, andHandler handler:@escaping () -> Void)
    {
        let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "Ok", style: .default)
        { (action) -> Void in
            return handler()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
// Hide Keyboard on taping Anywhere on view
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UIImageView {
    
    func downloadImage(from url: String) {
        if url == ""
        {
            return
        }
      let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }
        task.resume()
    }
    
}
