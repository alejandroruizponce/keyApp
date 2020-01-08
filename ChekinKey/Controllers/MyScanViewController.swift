//
//  MyScanViewController.swift
//  ScannerChekin
//
//  Created by Alejandro Ruiz Ponce on 14/11/2018.
//  Copyright © 2018 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit
import AVFoundation
import ScannerChekinIOS

protocol ProcessMRZ {
    func processMRZ(mrz:MRZParser)
}

class MyScanViewController: PassportScannerController {
    
    /// Delegate set by the calling controler so that we can pass on ProcessMRZ events.
    var delegate: ProcessMRZ?
    var isFlash: Bool = false
    var cr: DetectionAreaView!

    
    // the .StartScan and .EndScan are IBOutlets and can be linked to your own buttons
    @IBOutlet var buttonClose: UIButton!
    @IBOutlet var flashButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hero.isEnabled = true
        
        let width = self.view.frame.width/1.5
        let height = self.view.frame.height/2
        
        cr = DetectionAreaView(frame: CGRect(x: self.view.frame.width/2 - width/2 , y: self.view.frame.height/2 - height/2, width: width, height: height))
        cr.color = UIColor(white: 1, alpha: 0.8)
        cr.thickness = 3
        cr.backgroundColor = UIColor(white: 1, alpha: 0.0)

        self.view.addSubview(cr)

        
        buttonClose.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        flashButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)

        self.debug = true // So that we can see what's going on (scan text and quality indicator)
        self.accuracy = 1  // 1 = all checksums should pass (is the default so we could skip this line)
        self.mrzType = .auto // Performs a little better when set to td1 or td3
        //self.showPostProcessingFilters = false // Set this to true to to give you a good indication of the scan quality
        
        
    }
    
    


    
    @IBAction func setFlash(_ sender: Any) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            return
        }
        
        do {
            if !isFlash{
                try device.lockForConfiguration()
                try device.setTorchModeOn(level: 1)
                device.unlockForConfiguration()
                isFlash = true
            } else {
                try device.lockForConfiguration()
                try device.torchMode = .off
                device.unlockForConfiguration()
                isFlash = false
            }
            
            
        } catch {
            print("Torch is not working.")
        }
     }
    
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.StartScan(sender: self)
    }
    
    /**
     Called by the PassportScannerController when there was a succesfull scan
     
     :param: mrz The scanned MRZ
     */
    override func successfulScan(mrz: MRZParser) {
        print("mrz: {\(mrz.description)\n}")
        delegate?.processMRZ(mrz: mrz)
        let view = self.storyboard?.instantiateViewController(withIdentifier: "signUpController") as! SignUpFormViewController
        view.hero.modalAnimationType = .zoomOut
        present(view, animated: true, completion: nil)
    }
    
    
    /**
     Called by the PassportScannerController when the 'close' button was pressed.
     */
    override func abortScan() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "signUpController") as! SignUpFormViewController
        view.hero.modalAnimationType = .zoomOut
        present(view, animated: true, completion: nil)
    }
    
    
}
