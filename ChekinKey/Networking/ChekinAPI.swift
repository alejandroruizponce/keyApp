//
//  ChekinAPI.swift
//  ChekinKey
//
//  Created by Alejandro Ruiz Ponce on 06/02/2019.
//  Copyright © 2019 Alejandro Ruiz Ponce. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SignUpReponse: Decodable {
    let id: String
    let password: String
    let email: String
    let token: String
    
}

struct ChekinAPI {
    
    private static let baseURLLogin = "https://test3.chekin.io/api/v1/auth/phone/"
    private static let baseURLBooking = "https://test3.chekin.io/api/v1/tools/chekin_online/reservations/"
    private static let baseURLPoliceRegister = "https://test3.chekin.io/api/v1/tools/chekin_online/guests/police_register/"
    private static let baseURLBiomatching = "https://test3.chekin.io/api/v1/tools/biomatch/"
    static let path = Bundle.main.path(forResource: "KeyStagingChekin", ofType: "plist")
    static let keys = NSDictionary(contentsOfFile: path!)
    static let apiKey = keys!["Api-Key"] as! String
    static let tokenBioMatching = keys!["tokenBiomatching"] as! String
    static let tokenPoliceRegister = keys!["tokenRegisterPolice"] as! String
    static var success: Bool = false


    static func sendVerificationCode(_ phone: String) {
        let parameters = [
            "phone_number": phone
            ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Api-Key": apiKey
        ]
        
        AF.request("\(baseURLLogin)generate/", method: .post, parameters : parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("Envio de codigo de verificacion hecho con exito")
                    success = true
                default:
                    print("Error en el envio del codigo de verificación. response status: \(status)")

                }
            }
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                Profile.pk = ("\(JSON.object(forKey: "pk") as! Int)")
                print("El resultado de la solicitud de enviar codigo es: \(JSON)")
            }
        

        }
   
    }
    
    static func validateVerificationCode(_ otp: String,_ pk: String, completion: @escaping (_ result: String) -> ()) {
        let parameters = [
            "otp": otp,
            "pk": pk
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Api-Key": apiKey
        ]
        
        AF.request("\(baseURLLogin)validate/", method: .post, parameters : parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("Codigo de verificacion validado con exito")
                    success = true
                default:
                    print("Error en la verificación. response status: \(status)")
                    
                }
            }
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                Profile.token = JSON.object(forKey: "token") as! String
                let status = ("\(JSON.object(forKey: "status") as! Int)")
                completion(status)
                print("El resultado de la validacion del codigo es: \(JSON)")
            }
            

        }
        
    }
    
    static func getBookings(_ number: String, _ prefix: String, completion: @escaping (_ result: NSArray) -> ()){
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Api-Key": apiKey,
            "Authorization": tokenPoliceRegister
        ]
        
        AF.request("\(baseURLBooking)\(prefix)\(number)/", method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")
                
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("Lista de reservas recuperada con exito")
                default:
                    print("Error en el GET. response status: \(status)")
                }
            }
                
            if let result = response.result.value {
                let json = result as! NSArray
                print("La lista de reservas es: \(json)")
                completion(json)

            }
            
            
        }
        
        
    }
    
    static func uploadDocument(_ documentPicture: String) {
        
        let parameters = [
            "picture_file": documentPicture
        ]
        
        print("El token usado es: \(Profile.token)")
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": tokenBioMatching
        ]
        
        
        AF.request(("\(baseURLBiomatching)identification/"), method: .post, parameters : parameters, encoding: JSONEncoding.default , headers: headers).responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("Foto del documento subida con exito")
                    success = true
                default:
                    print("Error en la subida del documento. response status: \(status)")
                    
                }
            }
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                Profile.documentID = JSON.object(forKey: "id") as! String
                let faceDetected: Int = JSON.object(forKey: "is_face_detected") as! Int
                if faceDetected == 1 {
                    print("Se ha detectado la cara en el documento")
                } else {
                    print("CARA DOCUMENTO NO DETECTADA")
                }
                print("El resultado de subir la foto documento es: \(JSON)")
                print("El ID del documento es:\(Profile.documentID)")            }
            
        }


        
    }
    
    static func uploadSelfie(_ selfiePicture: String) {
        
        let parameters = [
            "picture_file": selfiePicture
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": tokenBioMatching
        ]
        
        AF.request("\(baseURLBiomatching)person/", method: .post, parameters : parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("Foto del Selfie subida con exito")
                default:
                    print("Error en la subida del Selfie. response status: \(status)")
                    
                }
            }
            
            if let result = response.result.value {

                let JSON = result as! NSDictionary
                Profile.selfieID = JSON.object(forKey: "id") as! String
                let faceDetected: Int = JSON.object(forKey: "is_face_detected") as! Int
                if faceDetected == 1 {
                    print("Se ha detectado la cara en el Selfie")
                } else {
                    print("CARA SELFIE NO DETECTADA")
                }
                print("El resultado de subir la foto Selfie es: \(JSON)")
                print("El ID del Selfie es:\(Profile.selfieID)")
            }
            
        }
    }
    
    static func setBiomatching(_ documentID: String, _ selfieID: String, completion: @escaping (_ result: AnyObject) -> Void) {
        
        let parameters = [
            "identification_picture": documentID,
            "person_picture": selfieID,
            ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": tokenBioMatching
        ]
        
        AF.request("\(baseURLBiomatching)compare/", method: .post, parameters : parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("Solicitud de Biotmatching HECHA")
                    success = true
                default:
                    print("Error en la solicitud de Biomatching. response status: \(status)")
                    
                }
            }
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                completion(JSON)
                print("El resultado de la solicitud de Biomatching es: \(JSON)")
            }
        
        }
    }
    
    static func getBiomatching(_ documentID: String, _ selfieID: String,  _ matchingID: String, completion: @escaping (_ result: AnyObject) -> Void) {

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": tokenBioMatching
        ]
        
        AF.request("\(baseURLBiomatching)compare/\(matchingID)/", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("Biomatching hecho con exito")
                    success = true
                default:
                    print("Error en el Biomatching. response status: \(status)")
                    
                }
            }
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                completion(JSON)
                print("El resultado del Biomatching es: \(JSON)")
            }
            
        }
    }
    
    static func uploadProfile() {
        
        let parameters = [
            "name": Profile.name,
            "first_surname": Profile.surname1,
            "second_surname": Profile.surname2,
            "nationality": Profile.nationality,
            "sex": Profile.sex,
            "birth_date": Profile.birthDate,
            "birth_place": "",
            "doc_type": Profile.documentType,
            "doc_number": Profile.documentCode,
            "doc_issue_date": Profile.emisionDate,
            "doc_isue_place": "",
            "guest_signature": Profile.signatureImage,
            "token": Profile.tokenBooking
            ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": tokenPoliceRegister
        ]
        
        AF.request("\(baseURLPoliceRegister)", method: .post, parameters : parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("Registro policia hecho con exito")
                    success = true
                default:
                    print("Error en el Registro Policia. response status: \(status)")
                    
                }
            }
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                print("El resultado del Registro Policia es: \(JSON)")
            }
            
        }
    }
    
    
    
    
    
}
