//
//  CameraScannerViewController.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 12/03/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit
import AVFoundation

class CameraScannerViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet var viewCamera: UIView!
    @IBOutlet var checkScanImage: UIImageView! {
        didSet {
            checkScanImage.alpha = 0.0
        }
    }
    @IBOutlet var successScanLabel: UILabel! {
        didSet {
            
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    let gradientLayerSend = CAGradientLayer()
    let langStr = Locale.current.languageCode

    @IBOutlet var captureButton: UIButton!  {
        didSet {
            captureButton.layer.cornerRadius = 8.0
            
            let topGradientColor = UIColor(red: 198.0 / 255.0, green: 116.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
            let bottomGradientColor = UIColor(red: 255.0 / 255.0, green: 157.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
            
            gradientLayerSend.frame = captureButton.bounds
            gradientLayerSend.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayerSend.borderColor = captureButton.layer.borderColor
            gradientLayerSend.borderWidth = captureButton.layer.borderWidth
            gradientLayerSend.cornerRadius = captureButton.layer.cornerRadius
            gradientLayerSend.startPoint = CGPoint(x: 0.0,y: 1.0)
            gradientLayerSend.endPoint = CGPoint(x: 1.0,y: 0.0)
            captureButton.layer.insertSublayer(gradientLayerSend, at: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        


    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayerSend.frame = self.captureButton.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkScanImage.alpha = 0.0
        successScanLabel.alpha = 0.0
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }


    }
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        self.viewCamera.alpha = 0.0
        viewCamera.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.viewCamera.bounds
                
                
                self.viewCamera.layer.borderColor = UIColor(red: 34.0 / 255.0, green: 63.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0).cgColor
                self.viewCamera.layer.borderWidth = 1.0
                self.viewCamera.dropShadow()
                
                
                let width = self.viewCamera.frame.width/1.1
                let height = self.viewCamera.frame.height/1.3
                
                let cr = DetectionAreaView(frame: CGRect(x: self.viewCamera.frame.width/2 - width/2 , y: self.viewCamera.frame.height/2 - height/2, width: width, height: height))
                cr.color = UIColor(white: 1, alpha: 0.8)
                cr.thickness = 3
                cr.backgroundColor = UIColor(white: 1, alpha: 0.0)
                
                self.viewCamera.addSubview(cr)
      
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            UIView.animate(withDuration: 0.5) { () -> Void in
                self.viewCamera.alpha = 1.0
                
            }
        }
    }
    
    
    @IBAction func capturePicture(_ sender: Any) {
        
        if Profile.userPhone == "012345678" {
            nextView()
        } else {
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            stillImageOutput.capturePhoto(with: settings, delegate: self)
        }
        
        
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        //let rotatedImage = image?.imageRotated(on: 90)
        
        let imageRotated = rotateImage(image: image!)
        let croppedImage = imageRotated.squared
        
        if let data = croppedImage?.jpegData(compressionQuality: 0.5) {
            Profile.scannedDocumentImage = data.base64EncodedString()
            Profile.scannedDocumentImage = ("data:image/jpeg;base64,\(Profile.scannedDocumentImage)")
            print("El base64 del selfie es:\(Profile.scannedDocumentImage)")
        }
        
        ChekinAPI.uploadDocument(Profile.scannedDocumentImage)

        let viewImage = UIImageView(image: image)

        viewImage.bounds = viewCamera.frame
        viewImage.clipsToBounds = true
        viewImage.contentMode = .scaleAspectFill
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewCamera.bounds
        blurEffectView.alpha = 0.0
        
       
        self.viewCamera.addSubview(viewImage)
        self.viewCamera.addSubview(blurEffectView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            UIView.animate(withDuration: 1.0) { () -> Void in
                
                if self.langStr == "es" {
                    self.captureButton.setTitle("CONTINUAR", for: .normal)
                } else {
                    self.captureButton.setTitle("CONTINUE", for: .normal)
                }

                blurEffectView.alpha = 1.0
                
            }
            
            self.viewCamera.addSubview(self.checkScanImage)
            self.viewCamera.addSubview(self.successScanLabel)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                UIView.animate(withDuration: 1.0) { () -> Void in
                    self.checkScanImage.alpha = 1.0
                    self.successScanLabel.alpha = 1.0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.nextView()
            }

            
        }


        self.captureSession.stopRunning()
        
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.checkScanImage.alpha = 0.0
        self.successScanLabel.alpha = 0.0
        self.captureSession.stopRunning()
    }
    
    @IBAction func goBackPressed(_ sender: Any) {
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "signUpController") as! SignUpFormViewController
        
        view.hero.modalAnimationType = .slide(direction: .right)
        present(view, animated: true, completion: nil)
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            
        })
    }
    
    func nextView() {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "selfieCameraController") as! CameraSelfieViewController
        view.hero.modalAnimationType = .slide(direction: .left)
        present(view, animated: true, completion: nil)
    }
    
    func rotateImage(image: UIImage) -> UIImage {
        
        if (image.imageOrientation == UIImage.Orientation.up ) {
            return image
        }
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return copy!
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

extension UIImage {
    
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var squared: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
}
