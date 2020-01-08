//
//  SignUpFormViewController.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 11/03/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import ScannerChekinIOS

class SignUpFormViewController: UIViewController, UITextFieldDelegate, ProcessMRZ {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            nameTextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            nameTextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            nameTextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            nameTextField.leftView = leftView
            nameTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var surname1TextField: UITextField! {
        didSet {
            surname1TextField.delegate = self
            surname1TextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            surname1TextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            surname1TextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            surname1TextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            surname1TextField.leftView = leftView
            surname1TextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var surname2TextField: UITextField! {
        didSet {
            surname2TextField.delegate = self
            surname2TextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            surname2TextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            surname2TextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            surname2TextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            surname2TextField.leftView = leftView
            surname2TextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var sexTextField: UITextField! {
        didSet {
            sexTextField.delegate = self
            sexTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            sexTextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            sexTextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            sexTextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            sexTextField.leftView = leftView
            sexTextField.leftViewMode = .always
        }
    }
    
    
    @IBOutlet var nationalityTextField: UITextField! {
        didSet {
            nationalityTextField.delegate = self
            nationalityTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            nationalityTextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            nationalityTextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            nationalityTextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            nationalityTextField.leftView = leftView
            nationalityTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var birthDateTextField: UITextField! {
        didSet {
            birthDateTextField.delegate = self
            birthDateTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            birthDateTextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            birthDateTextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            birthDateTextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            birthDateTextField.leftView = leftView
            birthDateTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var documentTypeTextField: UITextField! {
        didSet {
            documentTypeTextField.delegate = self
            documentTypeTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            documentTypeTextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            documentTypeTextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            documentTypeTextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            documentTypeTextField.leftView = leftView
            documentTypeTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var documentCodeTextField: UITextField!  {
        didSet {
            documentCodeTextField.delegate = self
            documentCodeTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            documentCodeTextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            documentCodeTextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            documentCodeTextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            documentCodeTextField.leftView = leftView
            documentCodeTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var emisionDateTextField: UITextField!   {
        didSet {
            emisionDateTextField.delegate = self
            emisionDateTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            emisionDateTextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            emisionDateTextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            emisionDateTextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            emisionDateTextField.leftView = leftView
            emisionDateTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var addButton: UIButton! {
        didSet {
            addButton.isEnabled = false
            addButton.alpha = 0.5
            addButton.layer.cornerRadius = 8.0
            
            let topGradientColor = UIColor(red: 198.0 / 255.0, green: 116.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
            let bottomGradientColor = UIColor(red: 255.0 / 255.0, green: 157.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
            
            gradientLayerSend.frame = addButton.bounds
            gradientLayerSend.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerSend.borderColor = addButton.layer.borderColor
            gradientLayerSend.borderWidth = addButton.layer.borderWidth
            gradientLayerSend.cornerRadius = addButton.layer.cornerRadius
            gradientLayerSend.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerSend.endPoint = CGPoint(x: 1.0,y: 0.0)
            addButton.layer.insertSublayer(gradientLayerSend, at: 0)
        }
    }
    
    
    @IBOutlet weak var buttonScan: UIButton! {
        didSet {
            buttonScan.layer.cornerRadius = 8.0
            
            let topGradientColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            let bottomGradientColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            gradientLayerRegister.frame = buttonScan.bounds
            gradientLayerRegister.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerRegister.borderColor = #colorLiteral(red: 0.8237543702, green: 0.5558829904, blue: 0.9284003377, alpha: 1)
            gradientLayerRegister.borderWidth = 1.0
            gradientLayerRegister.cornerRadius = buttonScan.layer.cornerRadius
            gradientLayerRegister.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerRegister.endPoint = CGPoint(x: 1.0,y: 0.0)
            buttonScan.layer.insertSublayer(gradientLayerRegister, at: 0)

        }
    }
    
    let gradientLayerRegister = CAGradientLayer()
    let gradientLayerSend = CAGradientLayer()
    let locale = Locale.init(identifier: "es_ES")
    var alertStyle: UIAlertController.Style = .actionSheet
    let langStr = Locale.current.languageCode
    var documentType = ""
    var IDNumber = ""
    var countryCode = ""
    var dateofBirth = ""
    var nationality = ""
    var firstName = ""
    var lastName = ""
    var passportNumber = ""
    var expirationD: String = ""
    var expirationDate = ""
    var dateOfB: String = ""
    var personalNumber: String = ""
    var sex = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if Profile.initiated > 0 {
           fillAllFields()
        }
        
        hideKeyboardWhenTappedAround()
        self.hero.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayerSend.frame = self.addButton.bounds
        gradientLayerRegister.frame = self.buttonScan.bounds
        
        buttonScan.bringSubviewToFront(buttonScan.imageView!)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        if textField.text?.characters.count == 1 {
            if textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        }
        checkAllFields()
    }
    
    func fillAllFields() {
        print("Rellenamos todos los campos")
        nameTextField.text = Profile.name
        nameTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        surname1TextField.text = Profile.surname1
        surname1TextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if Profile.sex == "M" {
            if langStr == "es" {
                sexTextField.text = "Masculino"
            } else {
                sexTextField.text = "Male"
            }
        } else {
            if langStr == "es" {
                sexTextField.text = "Femenino"
            } else {
                sexTextField.text = "Female"
            }
        }
        

        sexTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nationalityTextField.text = Profile.nationality
        nationalityTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        print("La fecha del profile es: \(Profile.birthDate)")
        birthDateTextField.text = Profile.birthDate
        birthDateTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        if Profile.documentType == "D" {
            if langStr == "es" {
                documentTypeTextField.text = "DNI"
            } else {
                documentTypeTextField.text = "ID Card"
            }
        } else if Profile.documentType == "P"  {
            if langStr == "es" {
                documentTypeTextField.text = "Pasaporte"
            } else {
                documentTypeTextField.text = "Passport"
            }
        } else if Profile.documentType == "PD"  {
            if langStr == "es" {
                documentTypeTextField.text = "P.Conducir"
            } else {
                documentTypeTextField.text = "D.License"
            }
        } else if Profile.documentType == "PR"  {
            if langStr == "es" {
                documentTypeTextField.text = "P.Residencia"
            } else {
                documentTypeTextField.text = "R.Permit"
            }
        }
        
        documentTypeTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        documentCodeTextField.text = Profile.documentCode
        documentCodeTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emisionDateTextField.text = Profile.emisionDate
        emisionDateTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        checkAllFields()
    }
    
    func checkAllFields() {
        
            guard
                let name = nameTextField.text, !name.isEmpty,
                let surname1 = surname1TextField.text, !surname1.isEmpty,
                let sex = sexTextField.text, !sex.isEmpty,
                let nationality = nationalityTextField.text, !nationality.isEmpty,
                let birthDate = birthDateTextField.text, !birthDate.isEmpty,
                let documentType = documentTypeTextField.text, !documentType.isEmpty,
                let documentCode = documentCodeTextField.text, !documentCode.isEmpty,
                let emision = emisionDateTextField.text, !emision.isEmpty
                else {
                    addButton.isEnabled = false
                    addButton.alpha = 0.5
                    return
            }
       

        addButton.isEnabled = true
        addButton.alpha = 1.0
    }
    
    func didTapStringPickerWithSexTextField(_ sender: UITextField) {
        if langStr == "es" {
            StringPickerPopover(title: "Sexo", choices: ["Masculino", "Femenino"])
                .setValueChange(action: { _, _, selectedString in
                    print("current string: \(selectedString)")
                })
                
                .setSelectedRow(0)
                .setSize(width: 250, height: 100)
                .setFont(UIFont.boldSystemFont(ofSize: 30))
                .setFontColor(#colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1))
                .setFontSize(25)
                .setCancelButton(title: "", font: UIFont.boldSystemFont(ofSize: 15), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    
                })
                .setDoneButton(title: "Hecho", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    self.sexTextField.text = selectedString
                    sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.checkAllFields()
                    
                })
                .appear(originView: sender, baseViewController: self)
        } else {
            StringPickerPopover(title: "Sex", choices: ["Male", "Female"])
                .setValueChange(action: { _, _, selectedString in
                    print("current string: \(selectedString)")
                })
                
                .setSelectedRow(0)
                .setSize(width: 250, height: 100)
                .setFont(UIFont.boldSystemFont(ofSize: 30))
                .setFontColor(#colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1))
                .setFontSize(25)
                .setCancelButton(title: "", font: UIFont.boldSystemFont(ofSize: 15), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    
                })
                .setDoneButton(title: "Done", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    self.sexTextField.text = selectedString
                    sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.checkAllFields()
                    
                })
                .appear(originView: sender, baseViewController: self)
        }

        
        
        
        
    
    }
    
    func didTapStringPickerWithDocumentTypeTextField(_ sender: UITextField) {
        
        if langStr == "es" {
            StringPickerPopover(title: "Tipo", choices: ["DNI", "Pasaporte","P.Conducir","P.Residencia"])
                .setValueChange(action: { _, _, selectedString in
                    print("current string: \(selectedString)")
                })
                
                .setSelectedRow(0)
                .setSize(width: 250, height: 100)
                .setFont(UIFont.boldSystemFont(ofSize: 30))
                .setFontColor(#colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1))
                .setFontSize(25)
                .setCancelButton(title: "", font: UIFont.boldSystemFont(ofSize: 15), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    
                })
                .setDoneButton(title: "Hecho", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    sender.text = selectedString
                    sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.checkAllFields()
                    
                })
                .appear(originView: sender, baseViewController: self)
        } else {
            StringPickerPopover(title: "Type", choices: ["ID Card","Passport","D.License","R.Permit"])
                .setValueChange(action: { _, _, selectedString in
                    print("current string: \(selectedString)")
                })
                
                .setSelectedRow(0)
                .setSize(width: 250, height: 100)
                .setFont(UIFont.boldSystemFont(ofSize: 30))
                .setFontColor(#colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1))
                .setFontSize(25)
                .setCancelButton(title: "", font: UIFont.boldSystemFont(ofSize: 15), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    
                })
                .setDoneButton(title: "Done", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    sender.text = selectedString
                    sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.checkAllFields()
                    
                })
                .appear(originView: sender, baseViewController: self)
        }

        
    }
    
    func didTapStringPickerWithNationalityTextField(_ sender: UITextField) {
        let locale = Locale.current
        let countries = Locale.isoRegionCodes.map {
            locale.localizedString(forRegionCode: $0)!
            }.sorted()
        
         if langStr == "es" {
            StringPickerPopover(title: "País", choices: countries)
                .setValueChange(action: { _, _, selectedString in
                    print("current string: \(selectedString)")
                })
                
                .setSelectedRow(67)
                .setSize(width: 300, height: 200)
                .setFont(UIFont.boldSystemFont(ofSize: 30))
                .setFontColor(#colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1))
                .setFontSize(25)
                .setCancelButton(title: "", font: UIFont.boldSystemFont(ofSize: 15), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    
                })
                .setDoneButton(title: "Hecho", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    sender.text = selectedString
                    sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.checkAllFields()
                    
                })
                .appear(originView: sender, baseViewController: self)
         } else {
            StringPickerPopover(title: "Country", choices: countries)
                .setValueChange(action: { _, _, selectedString in
                    print("current string: \(selectedString)")
                })
                
                .setSelectedRow(205)
                .setSize(width: 250, height: 200)
                .setFont(UIFont.boldSystemFont(ofSize: 30))
                .setFontColor(#colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1))
                .setFontSize(25)
                .setCancelButton(title: "", font: UIFont.boldSystemFont(ofSize: 15), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    
                })
                .setDoneButton(title: "Done", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedRow, selectedString in
                    sender.text = selectedString
                    sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.checkAllFields()
                    
                })
                .appear(originView: sender, baseViewController: self)
        }
        
    }
    
    func tapDatePickerButton(_ sender: UITextField) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"

        if langStr == "es" {
        /// DatePickerPopover appears:
        DatePickerPopover(title: "Fecha")
            .setDateMode(.date)
            .setSelectedDate(Date())
            .setValueChange(action: { _, selectedDate in
                print("current date \(selectedDate)")
            })
            .setDoneButton(title: "Hecho", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedDate in
                sender.text = df.string(from: selectedDate)
                sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.checkAllFields()
                
            })
            .setLocale(Locale.init(identifier: "es_ES"))
            .setCancelButton(title: "", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedDate in

                
            })
            .appear(originView: sender, baseViewController: self)
        } else {
            /// DatePickerPopover appears:
            DatePickerPopover(title: "Date")
                .setDateMode(.date)
                .setSelectedDate(Date())
                .setValueChange(action: { _, selectedDate in
                    print("current date \(selectedDate)")
                })
                .setDoneButton(title: "Done", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedDate in
                    sender.text = df.string(from: selectedDate)
                    sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.checkAllFields()
                    
                })
                .setLocale(Locale.init(identifier: "en_EN"))
                .setCancelButton(title: "", font: UIFont.boldSystemFont(ofSize: 16), color: #colorLiteral(red: 0, green: 0.3430114985, blue: 0.6686229706, alpha: 1), action: { popover, selectedDate in
                    
                    
                })
                .appear(originView: sender, baseViewController: self)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == sexTextField {
            view.endEditing(true)
            didTapStringPickerWithSexTextField(textField)
            return false
        }  else if textField == nationalityTextField {
            view.endEditing(true)
            didTapStringPickerWithNationalityTextField(textField)
            return false
        } else if textField == birthDateTextField {
            view.endEditing(true)
            tapDatePickerButton(textField)
            return false
        } else if textField == documentTypeTextField {
            view.endEditing(true)
            didTapStringPickerWithDocumentTypeTextField(textField)
            return false
        } else if textField == emisionDateTextField {
            view.endEditing(true)
            tapDatePickerButton(textField)
            return false
        } else if textField == documentCodeTextField {
            animateViewMoving(up: true, moveValue: 100)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == documentCodeTextField {
            animateViewMoving(up: false, moveValue: 100)
        }
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @IBAction func startScan(_ sender: Any) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "PassportScanner") as! MyScanViewController
        view.delegate = self
        view.hero.modalAnimationType = .zoom
        present(view, animated: true, completion: nil)
    }
    
    @IBAction func sendFormPressed(_ sender: Any) {

        Profile.name = nameTextField.text!
        Profile.surname1 = surname1TextField.text!
        if sexTextField.text == "Masculino" || sexTextField.text == "Male" {
            Profile.sex = "M"
        } else {
            Profile.sex = "F"
        }
        
        if let nation = nationalityTextField.text {
            Profile.nationality = locale(for: nation)
        }
        print("El codigo del pais es: \(Profile.nationality)")

        Profile.birthDate = birthDateTextField.text!
        
        if documentTypeTextField.text == "DNI" || documentTypeTextField.text == "ID Card" {
            Profile.documentType = "D"
        } else if documentTypeTextField.text == "Pasaporte" || documentTypeTextField.text == "Passport"  {
            Profile.documentType = "P"
        } else if documentTypeTextField.text == "P.Conducir" || documentTypeTextField.text == "D.License"  {
            Profile.documentType = "PD"
        } else if documentTypeTextField.text == "P.Residencia" || documentTypeTextField.text == "R.Permit"  {
            Profile.documentType = "PR"
        }

        Profile.documentCode = documentCodeTextField.text!
        Profile.emisionDate = emisionDateTextField.text!
        Profile.initiated += 1


        
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "scanningCameraController") as! CameraScannerViewController
        view.hero.modalAnimationType = .slide(direction: .left)
        present(view, animated: true, completion: nil)
    }
    
    private func locale(for fullCountryName : String) -> String {
        var locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode as! String
            }
        }
        return locales
    }
    
    func processMRZ(mrz:MRZParser) {
        
        print("Recopilamos todos los datos")

        if mrz.data()["documentSubType"] as? String == "D" || mrz.data()["documentType"] as? String == "I" {
            documentType = "I"
            IDNumber = "\(mrz.data()["IDNumber"] as! String)"
        } else if mrz.data()["documentType"] as? String == "P" {
            documentType = "P"
            passportNumber = "\(mrz.data()["IDNumber"] as! String)"
            if mrz.data()["personalNumber"] as! String != "" {
                personalNumber = "\(mrz.data()["personalNumber"] as! String)"
            }
        }
        
        
        nationality = "\(mrz.data()["nationality"]as! String)"
        nationality = countryName(countryCode: nationality)!
        if mrz.data()["sex"] as! String != "<"{
            sex = "\(mrz.data()["sex"]as! String)"
        }
        firstName = "\(mrz.data()["firstName"]as! String)"
        lastName = "\(mrz.data()["lastName"]as! String)"
        if mrz.data()["dateOfBirth"] as! String != "" {
            
            dateOfB = mrz.data()["dateOfBirth"] as! String
            let index1 = dateOfB.characters.index(dateOfB.characters.startIndex, offsetBy: 4)
            dateOfB.characters.insert("/", at: index1)
            let index2 = dateOfB.characters.index(dateOfB.characters.startIndex, offsetBy: 7)
            dateOfB.characters.insert("/", at: index2)
            
        }
        //Spanish format
        print("La fecha pre convertida es: \(dateOfB)")
        if langStr == "es" {
            dateOfB = convertEspDate(dateIn: dateOfB)
        } else {
            dateOfB = convertEngDate(dateIn: dateOfB)
        }

        print("La fecha convertida es: \(dateOfB)")
        dateofBirth = "\(dateOfB)"
        countryCode = "\(mrz.data()["countryCode"]as! String)"
        if mrz.data()["expirationDate"] as! String != ""{
            expirationD = mrz.data()["expirationDate"] as! String
            let index3 = expirationD.characters.index(expirationD.characters.startIndex, offsetBy: 4)
            expirationD.characters.insert("-", at: index3)
            let index4 = expirationD.characters.index(expirationD.characters.startIndex, offsetBy: 7)
            expirationD.characters.insert("-", at: index4)
        }
        if langStr == "es" {
            expirationD = convertEspDate(dateIn: expirationD)
        } else {
            expirationD = convertEngDate(dateIn: expirationD)
        }
        expirationDate = "\(expirationD)"
        
        var summary = "---------- RESULTADOS ----------" + "\n" + documentType + "\n" + nationality + "\n" + sex + "\n" + firstName + "\n" + lastName + "\n" + countryCode + "\n" + dateofBirth + "\n" + expirationDate + "\n"
        
        if mrz.data()["documentType"] as? String == "I" {
            summary = summary + IDNumber
        } else if mrz.data()["documentType"] as? String == "P" {
            summary = summary + passportNumber + "\n" + personalNumber
        }
        
        Profile.name = firstName.capitalizingFirstLetter()
        let fullsurname = lastName.components(separatedBy: " ")
        Profile.surname1 = fullsurname[0].capitalizingFirstLetter()
        for i in 1..<fullsurname.count{
            Profile.surname1 = ("\(Profile.surname1) \(fullsurname[i].capitalizingFirstLetter())")
        }

        
        if sex == "M" {
            Profile.sex = "M"
        } else {
            Profile.sex = "F"
        }
        Profile.nationality = nationality
        print("La fecha para meter en Profile es: \(dateOfB)")
        Profile.birthDate = dateOfB
        if documentType == "I" {
            Profile.documentType = "D"
        } else if documentType == "P" {
            Profile.documentType = "Pasaporte"
        }
        Profile.documentCode = IDNumber
        Profile.emisionDate = expirationDate
        Profile.initiated += 1

        fillAllFields()
        
        

        
        
        

    }
    
    func countryName(countryCode: String) -> String? {
        var id = ""
        if langStr == "es" {
            id = "esp_ESP"
        } else {
            id = "en_GB"
        }
        let current = Locale(identifier: id)
        return current.localizedString(forRegionCode: countryCode)
    }
    
    //Spanish format dd/mm
    func convertEspDate (dateIn: String) -> String {
        var resultString: String = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy/MM/dd"
        if let showDate = inputFormatter.date(from: dateIn) {
            inputFormatter.dateFormat = "dd-MM-yyyy"
            resultString = inputFormatter.string(from: showDate)
        }
        
        return resultString
    }
    
    //English format mm/dd
    func convertEngDate (dateIn: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy/MM/dd"
        let showDate = inputFormatter.date(from: dateIn)
        inputFormatter.dateFormat = "MM/dd/yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

