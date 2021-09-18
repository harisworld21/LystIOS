//
//  APIClient.swift
//  LystIOS
//
//  Created by HariRamya on 15/09/2021.
//
import Foundation
import UIKit

public struct ApiClient {

    static func getDataFromServer(urlString:String, completion: @escaping (_ success: Bool, _ data: Data?)->() ){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(false,nil)
            }
            guard let data = data else {
                completion(false,nil)
                return
            }
            completion(true,data)
            
        }.resume()
    }
    
    static func parse<T:Codable>(type:T.Type, data: Data)->T?{
        guard let R = try? JSONDecoder().decode(T.self, from: data) else
        {
            return nil
        }
        return R
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    static func downloadImage(from urlStr: String, completion: @escaping (UIImage?)->()) {
        print("Download Started")
        guard let url = URL(string: urlStr) else {
            completion(nil)
            return
        }
        getData(from: url) { data, response, error in
            guard let imageData = data,
                  let image = UIImage(data: imageData) else {
                completion(nil)
                return
            }
            completion(image)
        }
    }
}
