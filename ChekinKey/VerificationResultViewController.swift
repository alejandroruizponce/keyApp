//
//  VerificationResultViewController.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 10/01/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit

class VerificationResultViewController: UIViewController {
    
    @IBOutlet var successIndication: UILabel! = UILabel()
    
    var message: String?
    
    override func viewDidLoad() {
        if let resultToDisplay = message {
            successIndication.text = "¡Verificación realizada!"
        } else {
            successIndication.text = "Error durante la verificación"
        }
        super.viewDidLoad()
    }
}
