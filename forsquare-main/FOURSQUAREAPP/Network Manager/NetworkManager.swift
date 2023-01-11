//
//  NetworkManager.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//
import UIKit
import Foundation

class NetworkManager{
    func postData(url: String,parameters: [String:Any]?,header: [String: String]?,completion: @escaping(Any?, HTTPURLResponse , Error?) -> Void) {
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = header
        
        if let parameters = parameters {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = data
            } catch {
                print("Error: cannot create JSON from data")
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { responseData, response, error in
            print(type(of: responseData))
            if let response = response as? HTTPURLResponse {
                print("Response", response.statusCode)
                let body = String(data: responseData!, encoding: .utf8)
                print("Response body: \(String(describing: body))")
                if let data =  responseData{
                    do
                    {
                        if let jsonData = try JSONSerialization.jsonObject(with:data, options: .mutableContainers) as? [String:Any]{
                            completion(jsonData,response,nil)
                        }
                        else{
                            print(" networkfailed")
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                    
                }
                else{
                    print(error!.localizedDescription)
                }
                
                if response.statusCode == 200 {
                    completion(responseData, response, nil)
                }
            }
            if error != nil {
                print(error?.localizedDescription as Any, "error")
                completion(nil,response as! HTTPURLResponse,error)
            }
            
        }.resume()
    }
    
    func getData(at url: NSMutableURLRequest, completion: @escaping (Any?,Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url as URLRequest) {
            data, response, error in
            print("Reponse", response)
            if let apiData = data {
                do {
                    //                    if let jsonData = try JSONSerialization.jsonObject(with: apiData, options: .mutableContainers)
                    //                        as? Any{
                    //                        print(jsonData)
                    //                        completion(jsonData,nil)
                    //                    }
                    //                    else{
                    //                        print("networkfailed")
                    //
                    //                    }
                    let jsonData = try JSONSerialization.jsonObject(with: apiData, options: .mutableContainers)
                    print(jsonData)
                    completion(jsonData,nil)
                }
                catch{
                    print(error.localizedDescription, "this error")
                }
            }
        }
        task.resume()
    }
  
    func postReview(images: [UIImage],  placeId: String, review: String, completion: @escaping (Bool,Error?) -> Void) {
        
        let url = URL(string: "https://app-foursquare-230104103641.azurewebsites.net/user/review")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        
        var data = Data()
     
        
        request.allHTTPHeaderFields!["Authorization"] = token
        
        
        data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
        
        data.append("Content-Disposition: form-data; name=\"placeId\"\r\n\r\n".data(using: .utf8) ?? data as Data)
        
        data.append("\(placeId)\r\n".data(using: .utf8) ?? data as Data)
        
        
        data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
        
        data.append("Content-Disposition: form-data; name=\"review\"\r\n\r\n".data(using: .utf8) ?? data as Data)
        
        data.append("\(review)\r\n".data(using: .utf8) ?? data as Data)
        
        
        
        
        data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
        
        data.append("Content-Disposition: form-data; name=\"files\"\r\n\r\n".data(using: .utf8) ?? data as Data)
        
      
        
        data.append("--\(boundary)--\r\n".data(using: .utf8) ?? data as Data)
        data.append(createMultipartFormData(images: images, boundary: boundary))
        
        request.httpBody = data
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            print((response as? HTTPURLResponse)?.statusCode, "statuscode")
            
            let str = String(decoding: data!, as: UTF8.self)
            print(str)
            if let error = error {
                
                print("fail")
                
                print(response!,222222)
                
                completion(false,error)
                
                return
                
            }
            
            if let data = data {
                completion(true,nil)
                
            }
            
        }
        
        task.resume()
        
    }
    
    func createMultipartFormData(images: [UIImage], boundary: String) -> Data {
        let lineBreak = "\r\n"
        var formData = Data()
        
        for (index, image) in images.enumerated() {
            let data = image.jpegData(compressionQuality: 0.5)
            formData.append("--\(boundary + lineBreak)".data(using: .utf8) ?? formData as Data)
            formData.append("Content-Disposition: form-data; name=\"files\"; filename=\"image\(index + 1).jpg\"\(lineBreak)".data(using: .utf8) ?? formData as Data)
            formData.append("Content-Type: image/jpeg\(lineBreak + lineBreak)".data(using: .utf8) ?? formData as Data)
            formData.append(data!)
            formData.append(lineBreak.data(using: .utf8) ?? formData as Data)
        }
        
        formData.append("--\(boundary)--\(lineBreak)".data(using: .utf8) ?? formData as Data)
        return formData
    }
    func postFeedbackData(url: String,parameters: [String:Any],completion: @escaping(Any? , Error?) -> Void) {
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = data
        } catch {
            print("Error: cannot create JSON from data")
            return
        }
        
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { responseData, response, error in
            print(type(of: responseData))
            if let response = response as? HTTPURLResponse {
                print("Response", response.statusCode)
                let body = String(data: responseData!, encoding: .utf8)
                print("Response body: \(String(describing: body))")
                if response.statusCode == 200 {
                    completion(responseData,nil)
                }
                if error != nil {
                    print(error?.localizedDescription as Any, "error")
                    completion(nil,error)
                }}
            }.resume()
        }
}
