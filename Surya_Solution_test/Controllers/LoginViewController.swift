//
//  DetailsTableViewCell.swift
//  Surya_Solution_test
//
//  Created by Mraj singh on 28/02/19.
//  Copyright © 2019 Mraj singh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    let urlToRequest = "http://surya-interview.appspot.com/list"
    var profileData: [Items]?
    
    // Declaring the variable to cache data
    let cache = NSCache<NSString,NSArray>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListTableViewController {
            vc.profileDatalist = profileData
        }
    }
    
    @IBAction func login_pressed(_ sender: UIButton) {
        if let email = emailTF.text, email != ""{
            errorLabel.isHidden = true
            if let cached = cache.object(forKey: "items" as NSString) as? [Items]{
                profileData = cached
                self.performSegue(withIdentifier: "show_list", sender: nil)
            } else {
                dataRequest(email: email)
            }
            
        } else {
            errorLabel.isHidden = false
        }
    }
    
    
    
    
    //Function for API call
    func dataRequest(email:String) {
        let url4 = URL(string: urlToRequest)!
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = ["emailId":email]
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody  = try! JSONSerialization.data(withJSONObject: paramString, options: [])
        
        
        let task = session4.dataTask(with: request as URLRequest) { [weak self](data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            let dataDictionary = self?.convertToDictionary(text: dataString! as String)
            if let dictValueArray = dataDictionary!["items"] as? [[String:Any]]{
                var items = [Items]()
                for dictValue in dictValueArray {
                    let item = Items()
                    item.emailId = dictValue["emailId"] as? String
                    item.lastName = dictValue["lastName"] as? String
                    item.firstName = dictValue["firstName"] as? String
                    item.imageUrl = dictValue["imageUrl"] as? String
                    
                    items.append(item)
                    
                    
                }
                self?.profileData = items
                //Caching the data after first login
                self?.cache.setObject(items as NSArray, forKey: "items" as NSString)
                
            }
            
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "show_list", sender: nil)
                self?.emailTF.resignFirstResponder()
            }
            //JSONSerialization
        }
        task.resume()
    }
    
    //This converts string data to dictionary
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}


extension  LoginViewController {
    
    
    //This sets up login view
    func setUpViews(){
        logInButton.layer.cornerRadius = 3.0
        emailView.layer.cornerRadius = 4.0
        errorLabel.isHidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 150/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
}



