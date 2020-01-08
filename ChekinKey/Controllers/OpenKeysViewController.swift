//
//  OpenKeysViewController.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 11/01/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import UIKit
import Hero

class OpenKeysViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


    var listBooking:NSArray = []
    @IBOutlet var collectionView: UICollectionView!
    let flowLayout = ZoomAndSnapFlowLayout()
    var cell: BookingsCollectionViewCell!
    
    let cellScaling: CGFloat = 0.6
    

    @IBOutlet var titleReservas: UILabel!
    @IBOutlet var logoutButton: UIButton!
    
    var dateInBooking: String?
    var nights: Int?
    var guestPhone: String?
    var userPhone: String = Profile.userPhone
    var codeUserPhone: String = Profile.codePhone
    let langStr = Locale.current.languageCode
    @IBOutlet var statusBookingLabel: UILabel! {
        didSet {
            statusBookingLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true

        /*
        if let phone =  UserDefaults.standard.string(forKey: "userPhone") {
           if let code =  UserDefaults.standard.string(forKey: "codePhone") {
                print("El user Phone es: \(phone)")
              print("El codigo phone es: \(code)")*/
                ChekinAPI.getBookings("616506980", "34") {
                    (bookings) in
                    self.listBooking = bookings
                    self.collectionView.delegate = self
                    self.collectionView.reloadData()
                }

           // }
       // }

        
        collectionView.delegate = self
        collectionView.collectionViewLayout = flowLayout
    


    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("En total hay: \(listBooking.count) reservas")
  
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.listBooking.count == 0 {
                self.statusBookingLabel.isHidden = false
            } else {
                self.statusBookingLabel.isHidden = true
            }
        }
        return listBooking.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookingCard", for: indexPath) as? BookingsCollectionViewCell
        
        print("El index que se va escogiendo es: \(indexPath)")
        
        if let booking = listBooking[indexPath.row] as? NSDictionary {
            print("Recuperando reserva numero: \(indexPath.row)")
            cell.nameHotelLabel.text = booking.value(forKey: "accommodation_name") as? String
            if langStr == "es" {
                cell.roomNameLabel.text = "Habitación \(indexPath.row + 400)"
            } else {
                cell.roomNameLabel.text = "Room \(indexPath.row + 400)"
            }

            dateInBooking = booking.value(forKey: "check_in_date") as? String
            nights = booking.value(forKey: "nights_of_stay") as? Int
            guestPhone = booking.value(forKey: "guest_phone") as? String

        }
        
        
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    
        
        let radius = cell.keyMainDoor.frame.width/2.0
        
        cell.keyMainDoor.layer.cornerRadius = radius
        cell.keyRoomDoor.layer.cornerRadius = radius
        
        cell.keyMainDoor.layer.applySketchShadow()
        cell.keyRoomDoor.layer.applySketchShadow()
        

        
        cell.contentView.layer.cornerRadius = 12.0
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
            

        cell.layer.masksToBounds = false
        cell.layer.applySketchShadow()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            
            print("El index de Booking es: \(index)")
            
            let view = self.storyboard?.instantiateViewController(withIdentifier: "expandedBooking") as! ExpandedBookingViewController
           
            if let booking = collectionView!.cellForItem(at: index) as? BookingsCollectionViewCell{
                view.nameHotel = booking.nameHotelLabel.text!
                view.roomName = booking.roomNameLabel.text!
                view.location = booking.locationLabel.text!
                let dateEnd = addDays(days: nights!)
                print("La fecha final es: \(dateEnd)")
        
                view.date = ("\(parseStringDate(date: dateInBooking!)) - \(parseStringDate(date: dateEnd))")
                if let phone = guestPhone {
                    view.guestPhone = phone
                }


            }
            
            view.hero.modalAnimationType = .zoom
            present(view, animated: true, completion: nil)
         
        }
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isRegistered")
        UserDefaults.standard.removeObject(forKey: "userPhone")
        UserDefaults.standard.removeObject(forKey: "codePhone")
        UserDefaults.standard.synchronize()
         let view = self.storyboard?.instantiateViewController(withIdentifier: "mainRegisterView") as! StartVerificationViewController
        view.hero.modalAnimationType = .zoomOut
        present(view, animated: true, completion: nil)
    }
    
    func parseStringDate(date: String) -> String{
        
        var start = String.Index(encodedOffset: 0)
        var end = String.Index(encodedOffset: 4)
        let year = String(date[start..<end])
        
        start = String.Index(encodedOffset: 5)
        end = String.Index(encodedOffset: 7)
        let month = String(date[start..<end])
        
        start = String.Index(encodedOffset: 8)
        end = String.Index(encodedOffset: 10)
        let day = String(date[start..<end])
        
       return "\(day)/\(month)/\(year)"
        
    }
    
    func addDays(days: Int) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "es_ES") // set locale to reliable US_POSIX
        var date = dateFormatter.date(from:dateInBooking!)!
        
        date = date.add(days: days)!
        
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
        
        
    }
    

    

    
    
    /*
    func findDevices() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.omni = RPDemoHelper.shareInstance()
        }
    }*/
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            //findDevices()
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
    @IBAction func openLock(_ sender: Any) {
        omni?.omObject.startBLEScan(true)

        
        
    }*/


    
    
}


extension CALayer {
    func applySketchShadow(
        color: UIColor = #colorLiteral(red: 0.1490196078, green: 0.6, blue: 0.9843137255, alpha: 1),
        alpha: Float = 0.1,
        x: CGFloat = 0,
        y: CGFloat = 30,
        blur: CGFloat = 30,
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

extension Date {
    
    /// Returns a Date with the specified amount of components added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// Returns a Date with the specified amount of components subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        return add(years: -years, months: -months, days: -days, hours: -hours, minutes: -minutes, seconds: -seconds)
    }
    
}
