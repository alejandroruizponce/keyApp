//
//  SuccessfulSignUpViewController.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 15/03/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit

class SuccessfulSignUpViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet var getKeysButton: UIButton! {
        didSet {
            getKeysButton.layer.cornerRadius = 8.0
            
            
            let topGradientColor = UIColor(red: 198.0 / 255.0, green: 116.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
            let bottomGradientColor = UIColor(red: 255.0 / 255.0, green: 157.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
            
            gradientLayerGetKeys.frame = getKeysButton.bounds
            gradientLayerGetKeys.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerGetKeys.borderColor = getKeysButton.layer.borderColor
            gradientLayerGetKeys.borderWidth = getKeysButton.layer.borderWidth
            gradientLayerGetKeys.cornerRadius = getKeysButton.layer.cornerRadius
            gradientLayerGetKeys.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerGetKeys.endPoint = CGPoint(x: 1.0,y: 0.0)
            getKeysButton.layer.insertSublayer(gradientLayerGetKeys, at: 0)
        }
    }
    @IBOutlet var whatsAppButton: UIButton! {
        didSet {
            whatsAppButton.layer.cornerRadius = 8.0
            
            
            let topGradientColor = UIColor(red: 198.0 / 255.0, green: 116.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
            let bottomGradientColor = UIColor(red: 255.0 / 255.0, green: 157.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
            
            gradientLayerWhatsapp.frame = whatsAppButton.bounds
            gradientLayerWhatsapp.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerWhatsapp.borderColor = whatsAppButton.layer.borderColor
            gradientLayerWhatsapp.borderWidth = whatsAppButton.layer.borderWidth
            gradientLayerWhatsapp.cornerRadius = whatsAppButton.layer.cornerRadius
            gradientLayerWhatsapp.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerWhatsapp.endPoint = CGPoint(x: 1.0,y: 0.0)
            whatsAppButton.layer.insertSublayer(gradientLayerWhatsapp, at: 0)
        }
    }
    @IBOutlet var shareButton: UIButton!  {
        didSet {
            shareButton.layer.cornerRadius = 8.0
            
            
            let topGradientColor = UIColor(red: 198.0 / 255.0, green: 116.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
            let bottomGradientColor = UIColor(red: 255.0 / 255.0, green: 157.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
            
            gradientLayerShare.frame = shareButton.bounds
            gradientLayerShare.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerShare.borderColor = shareButton.layer.borderColor
            gradientLayerShare.borderWidth = shareButton.layer.borderWidth
            gradientLayerShare.cornerRadius = shareButton.layer.cornerRadius
            gradientLayerShare.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerShare.endPoint = CGPoint(x: 1.0,y: 0.0)
            shareButton.layer.insertSublayer(gradientLayerShare, at: 0)
        }
    }
    @IBOutlet var anotherRegisterButton: UIButton!  {
        didSet {
            anotherRegisterButton.layer.cornerRadius = 8.0

            let topGradientColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            let bottomGradientColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            gradientLayerRegister.frame = anotherRegisterButton.bounds
            gradientLayerRegister.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerRegister.borderColor = #colorLiteral(red: 0.8237543702, green: 0.5558829904, blue: 0.9284003377, alpha: 1)
            gradientLayerRegister.borderWidth = 1.0
            gradientLayerRegister.cornerRadius = anotherRegisterButton.layer.cornerRadius
            gradientLayerRegister.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerRegister.endPoint = CGPoint(x: 1.0,y: 0.0)
            anotherRegisterButton.layer.insertSublayer(gradientLayerRegister, at: 0)
        }
    }
    @IBOutlet var linkTextfield: UITextField! {
        didSet {
            linkTextfield.text = "https://api.chekin.io/lnk/9xa"
            linkTextfield.textColor = UIColor(red: 14.0  / 255.0, green: 129.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
            linkTextfield.layer.borderColor = UIColor(red: 0 / 255.0, green: 123.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0).cgColor
            linkTextfield.layer.borderWidth = 1.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
            linkTextfield.leftView = leftView
            linkTextfield.leftViewMode = .always
        }
    }
    
    @IBOutlet var congratulationsLabel: UILabel!
    let gradientLayerGetKeys = CAGradientLayer()
    let gradientLayerShare = CAGradientLayer()
    let gradientLayerRegister = CAGradientLayer()
    let gradientLayerWhatsapp = CAGradientLayer()
    let langStr = Locale.current.languageCode
    @IBOutlet var shareView: UIView! {
        didSet {
            shareView.isHidden = true
        }
    }
    @IBOutlet var miniShareView: UIView! {
        didSet {
            miniShareView.isHidden = true
            miniShareView.layer.cornerRadius = 5;
            miniShareView.layer.masksToBounds = true;
        }
    }
    @IBOutlet var logoChekinKey: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        
        UserDefaults.standard.set(Profile.userPhone, forKey: "userPhone")
        UserDefaults.standard.set(Profile.codePhone, forKey: "codePhone")
        UserDefaults.standard.set(true, forKey: "isRegistered")
        UserDefaults.standard.synchronize()
        
        self.view.addSubview(shareView)
        self.view.addSubview(miniShareView)
        layoutShareView()
        
        if langStr == "es" {
            congratulationsLabel.text = ("¡ENHORABUENA, \(Profile.name.uppercased())!")
        } else {
            congratulationsLabel.text = ("¡CONGRATULATIONS, \(Profile.name.uppercased())!")
        }

        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayerGetKeys.frame = self.getKeysButton.bounds
        gradientLayerShare.frame = self.shareButton.bounds
        gradientLayerRegister.frame = self.anotherRegisterButton.bounds
        gradientLayerWhatsapp.frame = self.whatsAppButton.bounds
        
        getKeysButton.bringSubviewToFront(getKeysButton.imageView!)
        whatsAppButton.bringSubviewToFront(whatsAppButton.imageView!)
        

        
        
        
        
    }
    
    func layoutShareView() {
        
        miniShareView.dropShadowMatching()
        
        shareView.translatesAutoresizingMaskIntoConstraints = false
        
        shareView.topAnchor.constraint(equalTo: self.logoChekinKey.bottomAnchor, constant: 0).isActive = true
        shareView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        shareView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        shareView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        miniShareView.translatesAutoresizingMaskIntoConstraints = false
        
        miniShareView.center = self.view.center
        
        
    }
    
    func setupShareView() {
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: self.view, duration: 0.5, options: transitionOptions, animations: {
            
            self.shareView.isHidden = false
            self.miniShareView.isHidden = false
            
        })
    }
    
    @IBAction func exitShareView(_ sender: Any) {
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: self.view, duration: 0.5, options: transitionOptions, animations: {
            
            self.shareView.isHidden = true
            self.miniShareView.isHidden = true
            
        })
    }
    
    @IBAction func shareLink(_ sender: Any) {
        setupShareView()
    }
    
    @IBAction func shareWhatsapp(_ sender: Any) {
        let originalString = linkTextfield.text
        let escapedString = originalString?.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
        let url  = URL(string: "whatsapp://send?text=\(escapedString!)")
        
        if UIApplication.shared.canOpenURL(url! as URL)
        {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func passToBooking(_ sender: Any) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "bookingsController") as! OpenKeysViewController
        
        view.hero.modalAnimationType = .zoom
        present(view, animated: true, completion: nil)
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
