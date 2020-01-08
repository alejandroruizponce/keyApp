//
//  ExpandedBookingViewController.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 27/02/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit
import Hero

class ExpandedBookingViewController: UIViewController, CBCentralManagerDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet var nameHotelExpanded: UILabel!
    @IBOutlet var locationExpanded: UILabel!
    @IBOutlet var dateExpanded: UILabel!
    @IBOutlet var roomNameExpanded: UILabel!
    @IBOutlet var infoBookingView: UIView!
    
    @IBOutlet var keyRoomExpanded: UIImageView!
    @IBOutlet var keyDoorExpanded: UIImageView!
    
    var nameHotel: String = ""
    var location: String = ""
    var roomName: String = ""
    var date: String = ""
    var guestPhone: String = ""
    
    var manager:CBCentralManager!
    
    @IBOutlet var featuresBookingView: UIView! {
        didSet {
            featuresBookingView.isHidden = true
        }
    }
    @IBOutlet var featureInfoView: UIView! {
        didSet {
            featureInfoView.layer.cornerRadius = 5;
            featureInfoView.layer.masksToBounds = true;
        }
    }
    
    @IBOutlet var titleFeature: UILabel!
    @IBOutlet var messageFeature: UILabel!
    @IBOutlet var buttonFeature: UIButton! {
        didSet {
            buttonFeature.contentHorizontalAlignment = .right
        }
    }
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CBCentralManager()
        manager.delegate = self
        
        self.view.addSubview(featuresBookingView)
        
        featuresBookingView.translatesAutoresizingMaskIntoConstraints = false
        
        featuresBookingView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        featuresBookingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        featuresBookingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        featuresBookingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        
        
        visualEffectView.frame = self.view.bounds
        
        nameHotelExpanded.text = nameHotel
        locationExpanded.text = location
        roomNameExpanded.text = roomName
        dateExpanded.text = date
        
        
        let radius = keyDoorExpanded.frame.width/2.0
        
        keyDoorExpanded.layer.cornerRadius = radius
        keyRoomExpanded.layer.cornerRadius = radius
        
        keyRoomExpanded.layer.applySketchShadow()
        keyDoorExpanded.layer.applySketchShadow()
        
        infoBookingView.layer.cornerRadius = 5.0
        infoBookingView.layer.masksToBounds = true
        
        self.hero.isEnabled = true
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyTapped(tapGestureRecognizer:)))
        keyDoorExpanded.isUserInteractionEnabled = true
        keyDoorExpanded.addGestureRecognizer(tapGestureRecognizer)
        
        keyRoomExpanded.isUserInteractionEnabled = true
        keyRoomExpanded.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func keyTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.visualEffectView.isHidden = false
        self.view.addSubview(visualEffectView)
        self.view.bringSubviewToFront(featuresBookingView)
        
        buttonFeature.isHidden = true
        messageFeature.text = "¡Ya puedes entrar!"
        titleFeature.text = "ABIERTA"
        
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: self.view, duration: 0.5, options: transitionOptions, animations: {
            
            self.featuresBookingView.isHidden = false
            
            
        })
        
       // OmnitecBluetoothAPI.openLock()
        
    }
    
    
    
    @IBAction func pressFeatureCall(_ sender: Any) {
        self.visualEffectView.isHidden = false
        self.view.addSubview(visualEffectView)
        self.view.bringSubviewToFront(featuresBookingView)
        
        buttonFeature.isHidden = false
        buttonFeature.setTitle("LLAMAR", for: .normal)
        messageFeature.text = "¿Deseas llamar al +\(guestPhone)?"
        
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: self.view, duration: 0.5, options: transitionOptions, animations: {
            
            self.featuresBookingView.isHidden = false
            
            
        })
    }
    
    @IBAction func pressCallAction(_ sender: Any) {
        if buttonFeature.titleLabel?.text == "LLAMAR" || buttonFeature.titleLabel?.text == "CALL"  {
            callNumber(phoneNumber: guestPhone)
        } else {
            let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
            UIView.transition(with: self.view, duration: 0.5, options: transitionOptions, animations: {
                
                self.visualEffectView.isHidden = true
                self.featuresBookingView.isHidden = true
                
                
            })
        }
        
    }
    
    
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func pressExitFeature(_ sender: Any) {
        
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: self.view, duration: 0.5, options: transitionOptions, animations: {
            
            self.visualEffectView.isHidden = true
            self.featuresBookingView.isHidden = true
            
            
        })
    }
    
    @IBAction func pressFeatureLocation(_ sender: Any) {
        
        self.visualEffectView.isHidden = false
        self.view.addSubview(visualEffectView)
        self.view.bringSubviewToFront(featuresBookingView)
        
        buttonFeature.setTitle("ABRIR EN MAPAS", for: .normal)
        messageFeature.text = "La dirección de tu hotel es: C/ Mehdi Fatemi numero 3. Menara. MARRAKESH"
        
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: self.view, duration: 0.5, options: transitionOptions, animations: {
            
            self.featuresBookingView.isHidden = false
            
            
        })
    }
    
    @IBAction func backtoCollection(_ sender: Any) {
        
        
        hero.modalAnimationType = .zoomOut
        hero.dismissViewController()
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth Activado. Buscando Omnitec...")
            //OmnitecBluetoothAPI.findDevices()
            break
        case .poweredOff:
            
            break
        case .resetting:
            break
        case .unauthorized:
            break
        case .unsupported:
            break
        case .unknown:
            break
        default:
            break
        }
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
