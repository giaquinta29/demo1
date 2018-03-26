//
//  ViewController.swift
//  demo_1
//
//  Created by Gianni on 21/3/18.
//  Copyright © 2018 Gianni. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var sw: UISwitch!
    @IBOutlet weak var birthdateDatePicker: UIDatePicker!
    
    @IBOutlet weak var waitActivityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    func isValidEmail(email:String)->Bool{
        return email.contains("@") && email.contains(".com")
    }
    func validPassword(pass:String,confPass:String)->Bool{
        
        if (pass==confPass){
            return true
        }
        return false
    }
    
    @objc func validate(){
        
        waitActivityIndicatorView.stopAnimating()
        success()
        
    }
    
    func success(){
        let alertController = UIAlertController(title: "Success", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
   
    
    @IBAction func switchValueChange(_ sender: Any) {
        signIn.isEnabled = sw.isOn
    }

    
    @IBAction func onTouch(_ sender: Any) {
        var confirmationEmail = false
        var confirmationPassword = false
        var confirmationBirthdate = false
        if let textEmail=email.text{
            confirmationEmail=isValidEmail(email: textEmail)
        }
        if let textPass=password.text,let textConfPass = confirmPassword.text {
            confirmationPassword=validPassword(pass: textPass, confPass: textConfPass)
        }
        if (birthdateDatePicker.date.timeIntervalSinceNow < -568036800) {
            confirmationBirthdate=true
        }
        if (confirmationEmail && confirmationPassword && confirmationBirthdate) {
        waitActivityIndicatorView.startAnimating()
            
           Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(validate), userInfo: nil, repeats: false)
            
        }else{
            if (confirmationEmail && confirmationBirthdate){
                let alertControllerPassword = UIAlertController(title: "Not matching password", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                
                alertControllerPassword.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertControllerPassword, animated: true, completion: nil)
            }else{
                if(confirmationBirthdate){
                let alertControllerEmail = UIAlertController(title: "Invalid Email", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                
                alertControllerEmail.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertControllerEmail, animated: true, completion: nil)
                }else{
                    let alertControllerBirthdate = UIAlertController(title: "Invalid Birthdate", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    
                    alertControllerBirthdate.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertControllerBirthdate, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    
    
}

