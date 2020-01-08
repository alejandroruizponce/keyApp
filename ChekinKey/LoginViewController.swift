//
//  LoginViewController.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 29/01/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

   
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        


        
        setupLayout()
        
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    func setupLayout() {
        
        
        /*
        loginView.translatesAutoresizingMaskIntoConstraints = false

        loginView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginView.topAnchor.constraint(equalTo: logoChekin.bottomAnchor, constant: 15).isActive = true
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginView.bottomAnchor.constraint(equalTo: labelQuestion.topAnchor, constant: -15).isActive = true
        
        registerView.translatesAutoresizingMaskIntoConstraints = false
        
        registerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerView.topAnchor.constraint(equalTo: logoChekin.bottomAnchor, constant: 15).isActive = true
        registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        registerView.bottomAnchor.constraint(equalTo: labelQuestion.topAnchor, constant: -15).isActive = true*/
    }
    
    @IBAction func changeView(_ sender: Any) {
        perform(#selector(flip), with: nil, afterDelay: 0.0)
    }
    
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        
        UIView.transition(with: loginView, duration: 1.0, options: transitionOptions, animations: {
            //self.SignView.isHidden = true
        })
        
        UIView.transition(with: registerView, duration: 1.0, options: transitionOptions, animations: {
            if self.registerView.isHidden {
                self.loginView.isHidden = true
                self.registerView.isHidden = false
                self.labelQuestion.setTitle("¿Ya tienes cuenta?", for: .normal)
                self.bottomButton.setTitle("ENTRAR", for: .normal)
                
            } else {
                self.loginView.isHidden = false
                self.registerView.isHidden = true
                self.labelQuestion.setTitle("¿No tienes cuenta?", for: .normal)
                self.bottomButton.setTitle("REGISTRARSE", for: .normal)
            }
        })
    }
    @IBAction func buttonRegister(_ sender: Any) {
        if let email = RegisterEmailField.text {
            if isValidEmail(testStr: email) {
                if let pass1 = RegisterPassword1Field.text {
                    if let pass2 = RegisterPassword2Field.text {
                        if pass1 == pass2 {
                            if isPasswordValid(pass1) {
                                ChekinAPI.newUser(email, pass1, completion: {
                                    self.perform(#selector(self.flip), with: nil, afterDelay: 0.0)
                                })
                            }
                        }
                    }
                }
            }
        }

        
    }
    
    @IBAction func buttonLogin(_ sender: Any) {
        if let email = LoginEmail.text {
            if isValidEmail(testStr: email) {
                if let pass = LoginPassword.text {
                    ChekinAPI.loginUser(email, pass, completion: {
                        print("Se ejecuta Completion")
                        if ChekinAPI.success {
                            self.performSegue(withIdentifier: "loginCompleted", sender: nil)
                        } 
                    })
                }
            }
        }
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isPasswordValid(_ Password : String) -> Bool{
        if Password.count > 6 {
            return true
        } else {
            return false
        }
    }


}


