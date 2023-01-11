//
//  RegistrationViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 06/01/23.
//

import Foundation
class RegistrationViewModel {
    
    var keyChainViewModel = KeyChain()
    
    var currentUser: User?
    
    func registerUser(completion: @escaping(Bool , Error?) -> Void) {
        let parameters = createParameterForRegistration()
        NetworkManager().postData(url: Urls.loginUrl.rawValue, parameters: parameters, header: nil) {data,response,error in
            if response.statusCode == 200 {
                if data != nil {
                    completion(true,nil)
                }
            }else if response.statusCode == 400 {
                if data != nil {
                    print("data", data)
                    completion(false,nil)
                }
            }
            
            else {
                completion(false,nil)
            }
        }
    }
    func createParameterForRegistration() -> [String: Any] {
        var parameter: [String: Any] = [:]
        if let user = currentUser {
            parameter["userName"] = user.userName
            parameter["email"] = user.email
            parameter["password"] = user.password
            parameter["phoneNumber"] = user.phoneNumber
        }
        return parameter
    }
    
    func loginUser(completion: @escaping(Bool , Error?) -> Void) {
        let header = createHeader()
        NetworkManager().postData(url: Urls.loginUrl.rawValue, parameters: nil, header: header) {data,response,error in
            if response.statusCode == 200 {
                if data != nil {
//                    print(type(of: data))
//                    print(data,"login data")
                    if let loginData = data{
                        guard let login = loginData as?  [String: Any] else {print("error1");return}
                        guard let token = login["token"] as? String else {print("error2");return}
                        print(token)
                        guard let userId = login["userId"] as? Int else {print("error3");return}
                        print(userId)
                        self.keyChainViewModel.deletePassword(userId: String(userId))
                        self.keyChainViewModel.saveData(userId: String(userId), data: token.data(using: .utf8) ?? Data())
                    }
                    
                    completion(true,nil)
                }
            }else if response.statusCode == 400 {
                if data != nil {
                    print("data", data)
                    completion(false,nil)
                }
            }
            
            else {
                completion(false,nil)
            }
        }
    }
    
    func createHeader() -> [String: String] {
        var header: [String: String] = [:]
        if let user = currentUser {
            header["email"] = user.email
            header["password"] = user.password
        }
        return header
    }
}
