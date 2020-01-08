//
//  StartVerificationViewController.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 10/01/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit
import MRCountryPicker
import Lottie

class StartVerificationViewController: UIViewController, MRCountryPickerDelegate, UITextFieldDelegate{
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet var phoneNumberTextField: UITextField!{
        didSet {
            phoneNumberTextField.delegate = self
            phoneNumberTextField.addTarget(self, action: #selector(self.phoneNumberDidChange(_:)), for: UIControl.Event.editingChanged)
            phoneNumberTextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            phoneNumberTextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            phoneNumberTextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            phoneNumberTextField.leftView = leftView
            phoneNumberTextField.leftViewMode = .always
        }
    }

    
    @IBOutlet var buttonSend: UIButton! {
        didSet {
            buttonSend.isEnabled = false
            buttonSend.alpha = 0.5
            buttonSend.layer.cornerRadius = 8.0
            
            let topGradientColor = UIColor(red: 198.0 / 255.0, green: 116.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
            let bottomGradientColor = UIColor(red: 255.0 / 255.0, green: 157.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
            
            gradientLayerSend.frame = buttonSend.bounds
            gradientLayerSend.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerSend.borderColor = buttonSend.layer.borderColor
            gradientLayerSend.borderWidth = buttonSend.layer.borderWidth
            gradientLayerSend.cornerRadius = buttonSend.layer.cornerRadius
            gradientLayerSend.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerSend.endPoint = CGPoint(x: 1.0,y: 0.0)
            buttonSend.layer.insertSublayer(gradientLayerSend, at: 0)
        }
    }
    
    @IBOutlet var buttonVerify: UIButton! {
        didSet {
            buttonVerify.layer.cornerRadius = 8.0
            
            let topGradientColor = UIColor(red: 198.0 / 255.0, green: 116.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
            let bottomGradientColor = UIColor(red: 255.0 / 255.0, green: 157.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
            
            gradientLayerVerify.frame = buttonVerify.bounds
            gradientLayerVerify.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerVerify.borderColor = buttonVerify.layer.borderColor
            gradientLayerVerify.borderWidth = buttonVerify.layer.borderWidth
            gradientLayerVerify.cornerRadius = buttonVerify.layer.cornerRadius
            gradientLayerVerify.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerVerify.endPoint = CGPoint(x: 1.0,y: 0.0)
            buttonVerify.layer.insertSublayer(gradientLayerVerify, at: 0)
        }
    }
    
    @IBOutlet var buttonFAQ: UIButton! {
        didSet {
            buttonFAQ.layer.masksToBounds = false
            buttonFAQ.layer.cornerRadius = 2.0
            
            buttonFAQ.layer.applyFAQShadow()
        }
    }
    

    @IBOutlet var countryPicker: MRCountryPicker! {
        didSet {
            countryPicker.countryPickerDelegate = self
            countryPicker.showPhoneNumbers = true
            
            if langStr == "es" {
                // optionally set custom locale; defaults to system's locale
                countryPicker.setLocale("es_ES")
            } else {
                // optionally set custom locale; defaults to system's locale
                countryPicker.setLocale("en_EN")
            }
            // set country by its code
            countryPicker.setCountry("ES")
        }
    }
    
    @IBOutlet var codeTextField: UITextField! {
        didSet {
            codeTextField.delegate = self
            codeTextField.addTarget(self, action: #selector(self.codeNumberDidChange(_:)), for: UIControl.Event.editingChanged)
            codeTextField.textContentType = .oneTimeCode
            codeTextField.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            codeTextField.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            codeTextField.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            codeTextField.leftView = leftView
            codeTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var verifiedView: UIView! {
        didSet {
            verifiedView.isHidden = true
            verifiedView.layer.cornerRadius = 5;
            verifiedView.layer.masksToBounds = true;
        }
    }
    
    @IBOutlet var loadingView: UIView! {
        didSet {
            loadingView.isHidden = true
        }
    }
    
    
    @IBOutlet var verifyngLabel: UILabel!
    
    @IBOutlet var finalNumberLabel: UILabel!
    @IBOutlet var RegisterView: UIView!
    @IBOutlet var verificationView: UIView! {
        didSet {
            verificationView.isHidden = true
        }
    }
    
    
    @IBOutlet var backButton: UIButton! {
        didSet {
            backButton.isHidden = true
        }
    }
    

    @IBOutlet var chekinLogo: UIImageView!
    var phoneCode: String = "+34"
    var finalPhone: String = ""
    let gradientLayerSend = CAGradientLayer()
    let gradientLayerVerify = CAGradientLayer()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let animationView = AnimationView(name: "animation-w200-h200")
    let langStr = Locale.current.languageCode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled = true
        
        //verificationView.frame = self.view.bounds
       // RegisterView.frame = self.view.bounds
       // loadingView.frame = self.view.bounds
        
        self.view.addSubview(RegisterView)
        self.view.addSubview(verificationView)
        self.view.addSubview(loadingView)
        self.view.addSubview(verifiedView)

        
        visualEffectView.frame = self.view.bounds
        setupLayout()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayerSend.frame = self.buttonSend.bounds
        gradientLayerVerify.frame = self.buttonVerify.bounds
        
    }

    
    
    func setupLayout () {
        
        
        RegisterView.translatesAutoresizingMaskIntoConstraints = false
        
        RegisterView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        RegisterView.topAnchor.constraint(equalTo: self.chekinLogo.topAnchor, constant: 0).isActive = true
        RegisterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        RegisterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        RegisterView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        verificationView.translatesAutoresizingMaskIntoConstraints = false
        
        verificationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        verificationView.topAnchor.constraint(equalTo: self.chekinLogo.topAnchor, constant: 0).isActive = true
        verificationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        verificationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        verificationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.topAnchor.constraint(equalTo: self.chekinLogo.topAnchor, constant: backButton.frame.height).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
        
        verifiedView.translatesAutoresizingMaskIntoConstraints = false
        
        verifiedView.center = self.view.center
        
        
        
    }
    
    

    
    @objc func phoneNumberDidChange(_ textField: UITextField) {
        phoneNumberTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if let phone = phoneNumberTextField.text {
            let phonef = phone.replacingOccurrences(of: " ", with: "")
            if phonef.count == 9 {
                view.endEditing(true)
                buttonSend.isEnabled = true
                buttonSend.alpha = 1.0
            }
        }
    }
    
    @objc func codeNumberDidChange(_ textField: UITextField) {
        codeTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if let code = codeTextField.text {
            let codef = code.replacingOccurrences(of: " ", with: "")
            if codef.count == 6 {
                view.endEditing(true)
                
            }
        }
    }

    
    @IBAction func sendVerification() {
        if let phone = phoneNumberTextField.text {
            let phonef = phone.replacingOccurrences(of: " ", with: "")
            if phonef == "012345678" {
                Profile.userPhone = "012345678"
                setupLoadingView()
                self.setupVerificationView()
            } else {
                if phonef.isPhoneNumber {
                    Profile.userPhone = phonef
                    Profile.codePhone = phoneCode.replacingOccurrences(of: "+", with: "")
                    
                    setupLoadingView()
                    self.setupVerificationView()
                    self.finalNumberLabel.text = self.phoneCode + " " + phonef
                    self.finalPhone = ("\(self.phoneCode)\(phonef)")
                    print("El telefono a verificar es: \(self.finalPhone)")
                    ChekinAPI.sendVerificationCode(self.finalPhone)
                  } else {
                    print("Numero incorrecto")
                }
            }
        } else {
            print("Numero incorrecto")
        }
    }

    
    func setupLoadingView() {
        
        self.visualEffectView.isHidden = false
        self.view.addSubview(visualEffectView)
        self.view.bringSubviewToFront(self.loadingView)
        
        verifyngLabel.translatesAutoresizingMaskIntoConstraints = false
        
        verifyngLabel.frame = CGRect(x: self.view.frame.size.width/2-100/2, y: self.view.frame.size.height/2-100/2 + 120 , width: 100, height: 18)
        
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: self.view, duration: 0.5, options: transitionOptions, animations: {

            self.loadingView.isHidden = false

            
        })
        

        

        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect(x: self.view.frame.size.width/2-100/2, y: self.view.frame.size.height/2-100/2, width: 100, height: 100)
        self.view.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play()

        
    }
    
    
    func setupVerifiedView() {
        
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: verificationView, duration: 1.0, options: transitionOptions, animations: {
            
            self.animationView.stop()
            self.animationView.removeFromSuperview()
            self.verifyngLabel.isHidden = true
            self.verifiedView.isHidden = false
            self.view.bringSubviewToFront(self.verifiedView)
            
        })
        

        verifiedView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                        self.verifiedView.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
  
    }
 
    
    
    @IBAction func verifyCode(_ sender: Any) {
        self.setupLoadingView()
        
        //TestMode
        if(Profile.userPhone == "012345678") {
            passToSignUp(sender)
        } else {
            if let code = codeTextField.text {
                ChekinAPI.validateVerificationCode(code, Profile.pk) { status in
                    if status == "200" {
                        print("Codigo correcto")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            self.setupVerifiedView()
                        }
                    } else {
                        self.loadingView.isHidden = true
                        self.animationView.stop()
                        self.animationView.removeFromSuperview()
                        self.visualEffectView.isHidden = true
                        self.view.bringSubviewToFront(self.verificationView)
                        print("Error en el codigo de verificacion")
                    }
                }
            }
        }
    }
    
    @IBAction func passToSignUp(_ sender: Any) {
        
        if self.phoneCode == "+34" {
            Profile.isSpanish = true
        }
        let view = self.storyboard?.instantiateViewController(withIdentifier: "signUpController") as! SignUpFormViewController
        
        view.hero.modalAnimationType = .zoom
        present(view, animated: true, completion: nil)
        
    }
    
    
    @IBAction func resendCode(_ sender: Any) {
        ChekinAPI.sendVerificationCode(finalPhone)
    }
    
    
    
    
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        self.phoneCode = phoneCode

    }
    
    @IBAction func backButton(_ sender: Any) {
        
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: RegisterView, duration: 1.0, options: transitionOptions, animations: {
            self.RegisterView.isHidden = false
            self.verificationView.isHidden = true
            self.loadingView.isHidden = true
            self.visualEffectView.isHidden = true
            self.verifyngLabel.isHidden = false
            
        })
    }
    
    
    func setupVerificationView() {
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        
        
        UIView.transition(with: verificationView, duration: 1.0, options: transitionOptions, animations: {
            self.RegisterView.isHidden = true
            self.loadingView.isHidden = true
            self.animationView.stop()
            self.animationView.removeFromSuperview()
            self.visualEffectView.isHidden = true
            self.backButton.isHidden = false
            self.verificationView.isHidden = false
 
        })

        

    }
    

    
  
    

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension CGRect {
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}


extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 3
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
}
    
    // OUTPUT 1
    func dropShadowMatching(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = #colorLiteral(red: 0.1206721887, green: 0.2435606718, blue: 0.4123970568, alpha: 1)
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 30)
        layer.shadowRadius = 10
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
}

extension CALayer {
    func applyFAQShadow(
        color: UIColor = #colorLiteral(red: 0.1490196078, green: 0.6, blue: 0.9843137255, alpha: 1),
        alpha: Float = 0.1,
        x: CGFloat = 0,
        y: CGFloat = 10,
        blur: CGFloat = 10,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
}

