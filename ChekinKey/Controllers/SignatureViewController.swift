//
//  SignatureViewController.swift
//  
//
//  Created by Alejandro Ruiz Ponce on 15/03/2019.
//

import UIKit

class SignatureViewController: UIViewController, YPSignatureDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet var signatureView: YPDrawSignatureView! {
        didSet {
            signatureView.layer.borderColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 0.9294117647, alpha: 1)
            signatureView.layer.borderWidth = 1.0
        }
    }
    
    var signed: Bool = false
    var checked: Bool = false
    var listBooking:NSArray = []
    var tokenBooking: String?
    
    @IBOutlet var checkButton: UIButton! {
        didSet {
            checkButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 0.9294117647, alpha: 1)
            checkButton.layer.borderWidth = 1.0
            checkButton.setImage(#imageLiteral(resourceName: "acceptIcon"), for: .normal)

            checkButton.imageView?.isHidden = true
        }
    }
    
    let gradientLayerSend = CAGradientLayer()
    let gradientLayerCheck = CAGradientLayer()
    
    @IBOutlet var signButton: UIButton!  {
        didSet {
            signButton.layer.cornerRadius = 8.0
            
            let topGradientColor = UIColor(red: 198.0 / 255.0, green: 116.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
            let bottomGradientColor = UIColor(red: 255.0 / 255.0, green: 157.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
            
            gradientLayerSend.frame = signButton.bounds
            gradientLayerSend.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerSend.borderColor = signButton.layer.borderColor
            gradientLayerSend.borderWidth = signButton.layer.borderWidth
            gradientLayerSend.cornerRadius = signButton.layer.cornerRadius
            gradientLayerSend.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerSend.endPoint = CGPoint(x: 1.0,y: 0.0)
            signButton.layer.insertSublayer(gradientLayerSend, at: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        

        signatureView.delegate = self
        
        signButton.isEnabled = false
        signButton.alpha = 0.5

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayerSend.frame = self.signButton.bounds
        

        
    }
    
    func didStart(_ view : YPDrawSignatureView) {
        print("Started Drawing")
        
        signed = true
        
        if signed && checked {
            signButton.isEnabled = true
            signButton.alpha = 1.0
        }
    }
    
    func didFinish(_ view: YPDrawSignatureView) {
        signed = true
        
        if signed && checked {
            signButton.isEnabled = true
            signButton.alpha = 1.0
        }
    }
    
    @IBAction func addSignature(_ sender: Any) {
         if let signatureImage = self.signatureView.getSignature(scale: 10) {
            //Converting to base64
            if let selfiebase64String = signatureImage.jpegData(compressionQuality: 0.5) {
                Profile.signatureImage = selfiebase64String.base64EncodedString()
                Profile.signatureImage = ("data:image/jpeg;base64,\(Profile.signatureImage)")
            }
            
            ChekinAPI.uploadProfile()
            
            let view = self.storyboard?.instantiateViewController(withIdentifier: "successfulSignUpController") as! SuccessfulSignUpViewController
            view.hero.modalAnimationType = .slide(direction: .left)
            present(view, animated: true, completion: nil)
        }
    }
    
    @IBAction func clearSignature(_ sender: Any) {
        signatureView.clear()
        signed = false
        signButton.isEnabled = false
        signButton.alpha = 0.5
    }
    
    @IBAction func checkAction(_ sender: Any) {
        if checked == false {
            checkButton.layer.borderWidth = 0.0
            checked = true

            let topGradientColor = UIColor(red: 198.0 / 255.0, green: 116.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
            let bottomGradientColor = UIColor(red: 255.0 / 255.0, green: 157.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
            
            gradientLayerCheck.frame = checkButton.bounds
            gradientLayerCheck.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerCheck.borderColor = checkButton.layer.borderColor
            gradientLayerCheck.borderWidth = checkButton.layer.borderWidth
            gradientLayerCheck.cornerRadius = checkButton.layer.cornerRadius
            gradientLayerCheck.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerCheck.endPoint = CGPoint(x: 1.0,y: 0.0)
            checkButton.layer.insertSublayer(gradientLayerCheck, at: 0)
            

            checkButton.imageView?.isHidden = false
            checkButton.bringSubviewToFront(checkButton.imageView!)
            
            if signed && checked {
                print("Activamos el boton")
                signButton.isEnabled = true
                signButton.alpha = 1.0
                
            } else {
                print("No se cumple")
            }
        } else {
            checked = false
            checkButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 0.9294117647, alpha: 1)
            checkButton.layer.borderWidth = 1.0
            gradientLayerCheck.removeFromSuperlayer()
            checkButton.imageView?.isHidden = true
            signButton.isEnabled = false
            signButton.alpha = 0.5
        }
    }
    
     @IBAction func goBack(_ sender: Any) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "selfieCameraController") as! CameraSelfieViewController
        view.hero.modalAnimationType = .slide(direction: .right)
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
