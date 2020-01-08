//
//  CheckVerificationViewController.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 10/01/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit

class CheckVerificationViewController: UIViewController {
    
    @IBOutlet var codeField: UITextField! = UITextField()
    @IBOutlet var errorLabel: UILabel! = UILabel()
    
    var countryCode: String?
    var phoneNumber: String?
    var resultMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeField.textContentType = .oneTimeCode
        codeField.becomeFirstResponder()
    }
    
    @IBAction func validateCode() {
        self.errorLabel.text = "" // reset
        
        if let code = codeField.text {
            VerifyAPI.validateVerificationCode(self.countryCode!, self.phoneNumber!, code) { checked in
                if (checked.success) {
                    self.resultMessage = checked.message
                    self.performSegue(withIdentifier: "checkResultSegue", sender: nil)
                } else {
                    self.errorLabel.text = "Código de verificación incorrecto"
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkResultSegue",
            let dest = segue.destination as? VerificationResultViewController {
            dest.message = resultMessage
        }
    }
}
