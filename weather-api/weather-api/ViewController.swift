//
//  ViewController.swift
//  weather-api
//
//  Created by saya on 2020/01/16.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textfield: UITextField!

    @IBAction func show(_ sender: UIButton) {
        var city: String = ""
        city = textfield.text!
        
        let config: URLSessionConfiguration = URLSessionConfiguration.default
         
         let session: URLSession = URLSession(configuration: config)
         
         //URL組み立て
         var urlComponents = URLComponents()
         urlComponents.scheme = "https"
         urlComponents.host = "api.openweathermap.org"
         urlComponents.path = "/data/2.5/weather"
         urlComponents.queryItems = [
             URLQueryItem(name: "APPID", value: "4b5774e9f3d2a07b84f0f2f88e486224"),
             URLQueryItem(name: "q", value: city)
         ]
         
         if let url: URL = urlComponents.url {
             
         }
         
         let url: URL = urlComponents.url!  //!を使う意味は、わざとクラッシュさせたいから？
         var req: URLRequest = URLRequest(url: url)
         req.httpMethod = "GET"
         
         let task = session.dataTask(with: req){(data, response, error) in
         let responseString: String =  String(data: data!, encoding: .utf8)!
             
         print(responseString)
             
             do {
                 let response: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                 
                 let weatherArray = response["weather"] as! [[String: Any]]
                 let weatherDescription = weatherArray[0]["description"]
                 
                 print(weatherDescription)
                 
                 DispatchQueue.main.async {
                     self.label.text = weatherDescription as! String
                 }
                 
             } catch{
                 
             }
             
         }
         task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

}

